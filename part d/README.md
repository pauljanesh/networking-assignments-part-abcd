# Sample Web App

A simple Flask web application containerized with Docker and deployed via Azure DevOps CI/CD pipeline.

## Prerequisites

- Docker
- Azure DevOps account
- Azure subscription
- Docker Hub account (or another container registry)

## Setup

1. Clone the repository.
2. Build the Docker image locally:
   ```
   docker build -t sample-web-app .
   ```
3. Run the container:
   ```
   docker run -p 80:80 sample-web-app
   ```
4. Access the app at http://localhost.

## CI/CD Pipeline

The Azure DevOps pipeline is configured in `azure-pipelines.yml`. It builds the Docker image and deploys it to Azure Web App for Containers.

### Pipeline Variables

Set the following variables in your Azure DevOps pipeline:

- `dockerId`: Your Docker Hub username
- `dockerRegistryServiceConnection`: Service connection to your container registry
- `azureSubscription`: Service connection to your Azure subscription
- `webAppName`: Name of your Azure Web App

## Demo

To demonstrate the pipeline:

1. Push code to the `main` branch.
2. The pipeline will trigger automatically.
3. Monitor the build and deployment in Azure DevOps.
4. Once deployed, access the app via the Azure Web App URL.
