# Use the official image as a parent image.
FROM php

# Set the working directory.
WORKDIR /back

COPY --from=composer /usr/bin/composer /usr/bin/composer

# Copy the file from your host to your current location.
COPY composer.json /back

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . /back

# Run the command inside your image filesystem.
RUN apt-get update && apt-get install -y git
RUN apt-get install -y \
        libzip-dev \
        zip \
  && docker-php-ext-install zip
RUN composer install --prefer-dist

# Add metadata to the image to describe which port the container is listening on at runtime.
EXPOSE 8000

# Run the specified command within the container.
CMD php artisan serve


