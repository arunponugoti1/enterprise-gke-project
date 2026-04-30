

#!/bin/bash
# Phase 2: Platform Bootstrapping Script

set -e

# 1. Connect to the GKE Cluster
echo "Connecting to GKE cluster..."
gcloud container clusters get-credentials enterprise-gke-cluster --region asia-south1

# 2. Install Anthos Service Mesh (Managed)
echo "Enabling Anthos Service Mesh..."
gcloud container fleet mesh enable --project fintech-platform-lab
gcloud container fleet memberships register enterprise-membership \
    --gke-cluster=asia-south1/enterprise-gke-cluster \
    --enable-workload-identity

# 3. Create Namespaces and Service Accounts
echo "Applying namespaces and PSA policies..."
kubectl apply -f platform/namespaces.yaml

# 4. Install ArgoCD
echo "Installing ArgoCD..."
kubectl create namespace argocd || true
kubectl apply -k platform/argocd/

# 5. Wait for ArgoCD to be ready
echo "Waiting for ArgoCD server..."
kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd

# 6. Apply Root Application (GitOps)
echo "Applying ArgoCD Root Application..."
kubectl apply -f platform/argocd/application.yaml

echo "Phase 2 completed successfully."
