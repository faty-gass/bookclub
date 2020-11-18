# Use the official image as a parent image.
FROM mysql

# Set the working directory.

ENV MYSQL_DATABASE="bookclub"
ENV MYSQL_ROOT_PASSWORD="root"

# Add metadata to the image to describe which port the container is listening on at runtime.
EXPOSE 3306

ADD bookclub.sql /docker-entrypoint-initdb.d
