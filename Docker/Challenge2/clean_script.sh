#!/bin/bash
docker rm teemii-backend
docker rm teemii-frontend
docker volume rm teemii-data
docker network rm teemii-network
