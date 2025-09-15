# Challenge: Advanced Monitoring with NGINX Amplify

## Issue
NGINX Amplify offers in-depth monitoring for NGINX-based web applications. 
It simplifies the process of analyzing and resolving issues related to performance and scalability.
The idea of this challenge is to create an advanced monitoring system with dashboards using NGINX Amplify.

# Solution

```bash
# Creating The respective files of the proyect
touch Dockerfile nginx.conf

# Create Docker the docker image that we are going to use
Docker build 

# Run a container with the image that we just created
Docker run

# Now that the container is running we need to access it and run the following commands to configure the Amplify agent.
docker exec -it <container_id> bash
curl -L -O https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh
API_KEY='<YOUR_API_KEY>' sh ./install.sh
'''

If you followed the steps above we should be able to open NGINX Amplify web portal an see our systems registered systems in the left coulumn of the page just like this:
IMAGE

 
