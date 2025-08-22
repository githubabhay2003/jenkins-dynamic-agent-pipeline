# Start from the official web server image
FROM httpd:2.4

# Switch to the root user to install software, then install curl
USER root
RUN apt-get update && apt-get install -y curl

# Copy our website file into the container's web directory
COPY ./index.html /usr/local/apache2/htdocs/

