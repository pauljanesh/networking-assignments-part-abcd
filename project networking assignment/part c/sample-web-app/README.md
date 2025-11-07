# Sample Web Application with Docker Deployment

## What the App Does
This is a simple Python Flask web application that serves a "Welcome to Docker Container" message on the root endpoint (/).

## How to Build and Deploy It
1. Ensure Docker and Ansible are installed on your system.
2. Navigate to the project directory: `cd sample-web-app`
3. Run the Ansible playbook: `ansible-playbook deploy.yml`
   - This will build the Docker image and run the container, exposing port 5000.

## Dependencies and Configuration Steps
- **Dependencies**:
  - Python 3.9
  - Flask 2.3.3
  - Docker
  - Ansible

- **Configuration Steps**:
  1. Install Docker: Follow the official Docker installation guide for your OS.
  2. Install Ansible: `pip install ansible` or use your OS package manager.
  3. Ensure Docker daemon is running.
  4. Run the deployment as described above.

After deployment, access the app at http://localhost:5000.
