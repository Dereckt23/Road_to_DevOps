# Challenge: Teemii Manga APP

## Issue
Teemii is a streamlined web application designed for the avid manga reader. It offers a straightforward and efficient platform for reading and managing a manga collection. 
Key features include cross-platform access, in-browser reading, a powerful metadata aggregator, and automated updates of your collection.
The idea is to Deploy Teemii using pre-built Docker images from Dockerhub, to be succesful in this challenge we should have to different containers with tha frontend and backend of the app communicating with each other and also having a persistent data management.
We are going to solve this challenge with to different approachs and then compare both solutions at the end to analize which one is better. 


# Solution1

```bash
# With this first approach we are going to use manual Docker commands, lets do it step by step

# The first thing that we want to do is create a network that will allow our containers to communicate with each other
docker network create teemii-network

# Then we need to create a volume so we can persist our data when our containers get removed.
docker volume create teemii-data

# Now we need to pull from docker hub the pre-build images that we need to start running our project
docker pull dokkaner/teemii-backend
docker pull dokkaner/teemii-frontend

# Finally we need to start running our containers specifying the network and volume that we just created, also we need to expose ports for the frontend so it can communicate with our local browsers
docker run -d --name teemii-backend --network teemii-network -v teemii-data:/data dokkaner/teemii-backend
docker run -d -p 8080:80 --name teemii-frontend --network teemii-network -e VITE_APP_TITLE=Teemii -e VITE_APP_PORT=80 dokkaner/teemii-frontend

# This step is optional if you want to clean the enviroment
docker stop teemii-backend
docker stop teemii-frontend
docker rm teemii-backend
docker rm teemii-frontend
docker volume rm teemii-data
docker network rm teemii-network
```

# Solution2

```bash
# This second approach will replacate the same steps as the first one but we are going to use docker compose to automate every step and be ready to go with a single command!

# Create a docker-compose.yml file and then run the up command, this command wil automatically create our containers, volumes and networks
docker compose up -d

# And then to stop the process we can use the stop command that will remove everything but the volume, which makes sense right?
docker compose down

# Finally we can use this mini script to clean the enviroment
./clean_script.sh
```

If everything went right in both aproaches you should be able to `http://localhost:8080` in your browser and see our containers making its magic!

<img width="2535" height="1257" alt="image" src="https://github.com/user-attachments/assets/e42277e8-1540-467a-bf3d-b95d8590a37b" />


## Conclusions

Now that we have everything ready we can analyze with detail were do this approaches excels.

| Metric | Manual | Automatic |
---------|--------|------------
| Time | Good if you need to do a quick test. | Better approach if you want to work with bigger projects. |
| Complexity | Is easy to work with it with 1 or 2 containers. | Excellent to orquestrate multiple containers but needs a yaml ramp up. |
| Reproducibility | Not great you will need to have a huge sheet of commands. | Really good, you just need to run the docker-compose file and reproduce it everywhere. |
|Maintenance| Really complicated especially in real projects. | Allows you to do modifications pretty easily.|
| CI/CD | Definitely not an option for pipelines automations. | Really good approach to add to a real world CI/CD pipeline automation. |
