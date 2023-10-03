# Omeka-S in docker

* Based on [klokantech/omeka-s-docker](https://github.com/klokantech/omeka-s-docker) with updates to:
    * Omeka-s version
    * Base PHP Apache container version
    * PHP Dependencies
    * Docker compose 

## Docker Compose

There is also example of docker-compose.yml file which can be used for development. It creates 3 containers:

* mysql db
* phpmyadmin
* omeka-s behind apache (modules or themes can be inserted via docker volumes
* docker-compose up

## TODO

* Add environment variables or volume mounts for key configuration
