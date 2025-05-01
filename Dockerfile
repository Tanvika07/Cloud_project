# Use a lightweight web server
FROM nginx:alpine

# Copy your HTML page into the server's default location
COPY index.html /usr/share/nginx/html/index.html