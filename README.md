# Genghis Docker image

A very light "ready to use" [Genghis](https://github.com/bobthecow/genghis) app based on Alpine.

## Supported tags and respective Dockerfile links

* [`2.3`, `2`, `latest` (2.3/Dockerfile)](https://github.com/dockervan/genghis/blob/master/2.3/Dockerfile)
* [`2.2` (2.2/Dockerfile)](https://github.com/dockervan/genghis/blob/master/2.2/Dockerfile)
* [`2.1` (2.1/Dockerfile)](https://github.com/dockervan/genghis/blob/master/2.1/Dockerfile)
* [`2.0` (2.0/Dockerfile)](https://github.com/dockervan/genghis/blob/master/2.0/Dockerfile)

## What is Genghis?

Genghis is a single-file MongoDB admin app, by [Justin Hileman](http://justinhileman.info/).

## How to use this image

### Start a Genghis instance

```bash
docker run --name genghis-app --link mongo-instance:db dockervan/genghis
```

You have to set at least one [mongo](https://hub.docker.com/_/mongo/) link named `db` to get Genghis working properly.

This image includes `EXPOSE 5678` (the Genghis default port),
so standard container linking will make it automatically available to the linked containers.

You can also publish the container port:

```bash
docker run --name genghis-app --link mongo-instance:db -p 5678:5678 dockervan/genghis
```

Genghis will be available on `http://localhost:5678`.

### Link multiple databases

You can link multiple databases to your Genghis app.
All links names must be prefixed by `db_`:

```bash
docker run --name genghis-app --link mongo-instance:db --link other-instance:db_2 --link mongofoo:db_foo -p 5678:5678 dockervan/genghis
```

### Use a custom servers dsn list

If you have a complex mongo structure that can not be compatible with the previous example,
you can add a `servers.custom` file that will contain arguments to give at the `--servers` option of Genghis.

Example of `servers.custom`:

```
db;localhost;42.42.42.42:25847
```

Once the file created, link it on docker command:

```bash
docker run --name genghis-app --link mongo-instance:db --volume /path/to/servers.custom:/servers.custom:ro dockervan/genghis
```

### Docker compose

Here a light example to use this image with docker-compose:

```yml
mongo:
  image: mongo:2.6

genghis:
  image: dockervan/genghis
  links:
    - mongo:db
  ports:
    - '8101:5678'
```

## Why using this image?

In contrary to the other [Genghis images](https://hub.docker.com/search/?isAutomated=0&isOfficial=0&page=1&pullCount=0&q=genghis&starCount=0),
this one is based on Alpine Linux OS and provide a very light application (less than 30 MB).

This method is perfect for "ready to use" application images.
You can see another example with [phpMyAdmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/) official image.
