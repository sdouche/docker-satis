# Docker Satis

Satis is a static Composer repository generator. The goal is to create a private
repository for your packages or a mirror for public packages.

## Quick start

1. Create the satis.json file

This file contains the URL of the packages (cf examples/satis.json).

2. Launch the container

```bash
docker run --name satis -d -p 8080:80 
    -v /path/to/your/dir/satis.json:/var/www/satis.json \
    sdouche/satis:latest
```

**Note**: *index.html* is generated at the end of download packages.

3. Go to localhost:8080

## Avoid the github limitation

A Github token is necessary to remove the download limitation (cf
examples/composer-config.json).

```bash
docker run --name satis -d \
    -v /path/to/your/dir/composer-config.json:/var/www/composer-config.json \
    sdouche/satis:latest
```


##  Save the packages outside the container

```bash
docker run --name satis -d \
    -v /path/to/your/dir/:/var/www \
    sdouche/satis:latest
```

## Enabling the SSH Key

```bash
docker run --name satis -d \
    -v /path/to/your/dir/:/root/.ssh \
    sdouche/satis:latest
```

## Enabling the HTTPS

Add `satis.key` and `satis.crt` in folder `certs`.

```bash
docker run --name satis -d \
    -p 8443:443
    -e "SATIS_HTTPS=true" \
    -v /path/to/your/dir/certs:/var/www/certs \
    sdouche/satis:latest
```
