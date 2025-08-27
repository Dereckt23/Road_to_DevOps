# Challenge: Docker Compose mini APP

## Issue
Create a mini app using docker compose in order to undesrtand how Docker compose and Volumes in Docker works.

# Solution

```bash
# Creating The respective files of the proyect
touch docker-compose.yml Dockerfile server.js data_flush.sh

# Build and start running!
docker compose up --build

# Requests to the server
curl -s http://localhost:3000
curl -s http://localhost:3000/test

# Check inside the container that /data is owned by 1001:1001 and that events.log exists
docker exec -it compose-hooks-app sh -c 'id && ls -l /data && tail -n +1 /data/events.log || true'

# Execute the pre-stop
docker compose down or Ctrl+c

# Run an ephimeral container to check if the data persists thanks to docker volumes
docker run --rm -v challenge1_data:/data alpine sh -c "ls -lh /data && cat /data/flush.info || true"
```
