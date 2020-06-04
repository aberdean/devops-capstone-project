# Cloud DevOps Capstone Project

Capstone project for the Udacity Cloud DevOps Engineer Nanodegree

## Project Overview

This project creates a Kubernetes cluster on AWS with [`eksctl`](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html).
It then deploys a Docker container with a simple `Hello World` app running on `nginx`.
It demonstrates HTML and Docker linting, uploading of a Docker image on Docker Hub, and finally, pulling the image from Docker Hub and
deploying it to the AWS Kubernetes cluster. It also demonstrates a rollout deployment.

## Prerequisites

- An EC2 instance running Jenkins

## Running the Project

1. Deploying and configuring the cluster - set the path for the Jenkins build to `setup-cluster/Jenkinsfile` and trigger a build
2. Wait for the build to finish successfully, then copy the cluster ARN to the `Set current kubectl context` stage of the Jenkins pipeline in the root `Jenkinsfile`
3. Deploying the app - set the path for the Jenkins build to `Jenkinsfile`
4. To check the rollout deployment - change the app version in the `Jenkinsfile` and `deployment.yaml` file and trigger a new build


## Project Structure

The project includes one directory: `setup-cluster` with the `Jenkinsfile` to deploy the AWS Kubernetes cluster,
and the following files:
- `.gitignore`, to list files that Git should ignore
- `deployment.yaml`, to setup the app and the deployment strategy
- `Dockerfile`, to specify the container
- `index.html`, to write the "Hello World" page
- `Jenkinsfile`, to deploy the app to the AWS cluster
- `LICENSE`, containing info on the license
- `README.md`, this file
- `service.yaml`, to expose the app


## Authors

- Antonella Bernobich Dean - [aberdean](https://github.com/aberdean)


## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/aberdean/static/blob/master/LICENSE) file for details.
