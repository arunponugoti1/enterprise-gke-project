#!/bin/bash
PROJECT_ID=$(gcloud config get-value project)
REGION="asia-south1"
REPO="enterprise-docker-repo"
BASE_TAG="asia-south1-docker.pkg.dev/${PROJECT_ID}/${REPO}"
VERSION=$(git rev-parse --short HEAD)
if [ -z "$VERSION" ]; then
    VERSION="v1"
fi

SERVICES=(
    "adservice"
    "cartservice"
    "checkoutservice"
    "currencyservice"
    "emailservice"
    "frontend"
    "loadgenerator"
    "paymentservice"
    "productcatalogservice"
    "recommendationservice"
    "shippingservice"
    "shoppingassistantservice"
)

for SERVICE in "${SERVICES[@]}"; do
    echo "Building ${SERVICE} with tag ${VERSION}..."
    if [ "$SERVICE" == "cartservice" ]; then
        docker build -t "${BASE_TAG}/${SERVICE}:${VERSION}" "./online-boutique/src/${SERVICE}/src"
    else
        docker build -t "${BASE_TAG}/${SERVICE}:${VERSION}" "./online-boutique/src/${SERVICE}"
    fi
    echo "Pushing ${SERVICE}..."
    docker push "${BASE_TAG}/${SERVICE}:${VERSION}"
done
