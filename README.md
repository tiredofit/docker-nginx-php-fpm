# hub.docker.com/tiredofit/nginx-php-fpm

# Introduction

Dockerfile to build a [Nginx](https://www.nginx.org) w/[PHP-FPM](https://php.net) container image.

* This Container uses Alpine as a base which includes [s6 
overlay](https://github.com/just-containers/s6-overlay) enabled for PID 1 Init capabilities, 
[zabbix-agent](https://zabbix.org) based on TRUNK compiled for individual container monitoring, Cron also 
installed along with other tools (bash,curl, less, logrotate, mariadb-client, nano, vim) for easier 
management.
* Caching is provided with w/ APC, OpCache
* PHP Extensions included are: 
          php7-apcu,
          php7-bcmath,
          php7-ctype,
          php7-curl,
          php7-dom,
          php7-fpm,
          php7-gd,
          php7-iconv,
          php7-intl,
          php7-json,
          php7-ldap,
          php7-mbstring,
          php7-mcrypt,
          php7-memcached,
          php7-mysqli,
          php7-opcache,
          php7-openssl,
          php7-pdo,
          php7-pdo_mysql,
          php7-pdo_sqlite,
          php7-phar\
          php7-redis,
          php7-session,
          php7-xml,
          php7-xmlreader,
          php7-zlib,


[Changelog](CHANGELOG.md)

# Authors

- [Dave Conroy](http://github/tiredofit/)

# Table of Contents

- [Introduction](#introduction)
    - [Changelog](CHANGELOG.md)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Database](#database)
    - [Data Volumes](#data-volumes)
    - [Environment Variables](#environmentvariables)   
    - [Networking](#networking)
- [Maintenance](#maintenance)
    - [Shell Access](#shell-access)
   - [References](#references)

# Prerequisites

This image assumes that you are using a reverse proxy such as 
[jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) and optionally the [Let's Encrypt Proxy 
Companion @ 
https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion) 
in order to serve your pages. However, it will run just fine on it's own if you map appropriate ports.



# Installation

Automated builds of the image are available on [Registry](https://hub.docker.com/tiredofit/nginx-php-fpm) 
and is the recommended method of installation.


```bash
docker pull hub.docker.com/tiredofit/nginx-php-fpm:(imagetag)
```

The following image tags are available:

* `5.3-latest` - PHP 5.3.29 w/Alpine 3.4
* `5.5-latest` - PHP 5.5..38 w/Alpine 3.4
* `5.6-latest` - PHP 5.6.x w/Alpine 3.5
* `7.0-latest` - PHP 7.0.x w/Alpine 3.5
* `7.1-latest` - PHP 7.1.x w/Alpine 3.6
* `7.1-ldap-latest` - PHP 7.1.x w/LDAP Authentication w/Alpine 3.6
* `latest` - Most recent release of PHP w/most recent Alpine Linux

# Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the 
examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for 
development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this 
image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

# Configuration

### Data-Volumes

The container starts up and reads from `/etc/nginx/nginx.conf` for some basic configuration and to listen 
on port 73 internally for Nginx Status responses. `/etc/nginx/conf.d` contains a sample configuration file 
that can be used to customize a nginx server block. 

The following directories are used for configuration and can be mapped for persistent storage.

| Directory | Description |
|-----------|-------------|
| `/www/html` | Root Directory |
| `/www/logs` | Nginx and php-fpm logfiles |

### Database

No Database Required - MariaDB Client is located within the image.

### Environment Variables

Along with the Environment Variables from the Base image, below is the complete list of available options 
that can be used to customize your installation.

| Parameter | Description |
|-----------|-------------|
| `PHP_MEMORY_LIMIT` |Amount of memory php-fpm process should use (Default `128M`) |
| `PHP_LOG_LEVEL` | Define verbosity: (e.g `debug`, `info`, `notice`, `warning`, `error`, `critical`, and 
`alert` - Default `info`)
| `PHP_TIMEOUT`   | Sets Read and Write Timeouts for Nginx FastCGI (Default `300`) |
| `UPLOAD_MAX_SIZE` | Maximum Upload Size: (Default `2G`) |
| `APC_SHM_SIZE` | PHP7 APC SHM Cache Size: (Default `128M`) |
| `OPCACHE_MEM_SIZE` | PHP7 OPCache Size - Select `0` to Disable (Default `128`) |
| `TZ` | Timezone - Use Unix Timezone format (Default `America/Vancouver`) |

### Networking

The following ports are exposed.

| Port      | Description |
|-----------|-------------|
| `80` 		| HTTP 		  |

# Maintenance
#### Shell Access

For debugging and maintenance purposes you may want access the containers shell. 

```bash
docker exec -it (whatever your container name is e.g. nginx-php-fpm) bash
```

# References

* https://www.nginx.org
* http://www.php.org


