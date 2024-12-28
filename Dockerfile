# Use a lightweight Alpine base image
FROM alpine:latest

# Install Apache2
RUN apk add --no-cache apache2 && \
    mkdir -p /run/apache2

# Copy application files to Apache's web root
COPY . /var/www/localhost/htdocs/

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Apache in the foreground
CMD ["httpd", "-D", "FOREGROUND"]

