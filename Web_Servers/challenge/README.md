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
docker build -t nginx-amplify .

# Run a container with the image that we just created
docker run -d --name monitoring_amplify nginx-amplify

# Now that the container is running we need to access it and run the following commands to configure the Amplify agent.
docker exec -it <container_id> bash
curl -L -O https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh
API_KEY='<YOUR_API_KEY>' sh ./install.sh
```

If you followed the steps above we should be able to open NGINX Amplify web portal an see our systems registered systems in the left coulumn of the page just like this:

<img width="975" height="468" alt="image" src="https://github.com/user-attachments/assets/f55d1692-e5ed-4d83-9bf1-30f423d491a3" />

Then we can start with our analysis, the first thing that we want to do is to create a dashboard you can refer to the oficial documention [here](https://docs.nginx.com/nginx-amplify/user-interface/dashboards/).
Once we do that lets do something intersting, what we want to do is to simulate high trafic in our web server to see how it behaves. You can use this command 'ab -n 10000 -c 1000 http://localhost/' to simulate trafic.

<img width="975" height="593" alt="image" src="https://github.com/user-attachments/assets/e6aa6d16-6fa7-48c8-8aee-9b881a26e078" />

According to the image above we can observe that the graphics started to increase dramatically due to high traffic (Important to mention that we are doing this experiment with the default configurations of our nginx.conf file).
 * CPU usage went from 1.7% to 10% approximately.
 * The load average went from 0.10 to almost 0.80 approximately.
 * The memory used does not seems to have relevant changes.


Now lets change the rules of the game a little bit!
Inside the container open the following config file: '/etc/nginx/nginx.conf'.
Then change the value of  this variable 'worker_connections 1024' to 'worker_connections 5000' in order to increase the number of connections that a process can handle simultaneously.
Lets check how the graphics behave now.

<img width="975" height="374" alt="image" src="https://github.com/user-attachments/assets/9085f0f6-43f9-4a95-b367-5c45c885722d" />

So now we can see in the second peak of the graph some interesting things.
 * CPU usage went from 10% in the first peak to 13% in the second peak.
 * The load average went from 0.80 in the first peak to 0.87 approximately.
 * The memory used does not seems to have relevant changes.

This experiment was succesful and tells us a lot about how real production enviroments work!
Basically what we are seeing is that when we increase our amount of simultaneous connections the CPU had a significant increase of usage which was expected because now our hardware need to support more users and requests.
But in the other hand we can observe that the increase of the opeak in the load graph wasn't as significant as the CPU one, this is because our CPU was able to handle those request succesfully without queueing any of the requests.

# Conclusions

With this experiment we can conclude that scaling with NGINX is super easy, but it can be dangerous if we don't monitor our traffic and resources correctly.
Because if you set an amount of simultaneous connections that your hardware can't handle there's when the load graph is going tho increase dramatically and we don't want that because that would mean that there would be users that are going to get left in a queue until we increase our resources or implement a better loas balancing system.



 
