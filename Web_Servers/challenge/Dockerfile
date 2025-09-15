FROM nginx:latest

# Install dependecies and packages that we need to complete the challange
RUN apt-get update && \
    apt-get install -y python3 python3-pip apache2-utils nano curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy our NGINX config into the NGINX container config
COPY nginx.conf /etc/nginx/nginx.conf

# Create stub_status.conf so NGINX can expose metrics
RUN mkdir -p /etc/nginx/conf.d && \
    echo 'server {\n\
    listen 127.0.0.1:80;\n\
    server_name 127.0.0.1;\n\
    location /nginx_status {\n\
        stub_status on;\n\
        allow 127.0.0.1;\n\
        deny all;\n\
    }\n\
}' > /etc/nginx/conf.d/stub_status.conf

