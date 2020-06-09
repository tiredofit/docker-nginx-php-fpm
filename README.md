# hub.docker.com/r/tiredofit/nginx-php-fpm

[![Build Status](https://img.shields.io/docker/build/tiredofit/nginx-php-fpm.svg)](https://hub.docker.com/r/tiredofit/nginx-php-fpm)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/nginx-php-fpm.svg)](https://hub.docker.com/r/tiredofit/nginx-php-fpm)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/nginx-php-fpm.svg)](https://hub.docker.com/r/tiredofit/nginx-php-fpm)
[![Docker 
Layers](https://images.microbadger.com/badges/image/tiredofit/nginx-php-fpm.svg)](https://microbadger.com/images/tiredofit/nginx-php-fpm)


# Introduction

Dockerfile to build a [Nginx](https://www.nginx.org) w/[PHP-FPM](https://php.net) container image.

* This Container uses a [customized Alpine Linux base](https://hub.docker.com/r/tiredofit/alpine) which includes [s6 overlay](https://github.com/just-containers/s6-overlay) enabled for PID 1 Init capabilities, [zabbix-agent](https://zabbix.org) for individual container monitoring, Cron also installed along with other tools (bash,curl, less, logrotate, mariadb-client, nano, vim) for easier management. It also supports sending to external SMTP servers..
* Debug Mode to Enable XDebug
* Caching is provided with w/ APC, OpCache
* Enabled by default extensions are: apcu, bcmath, ctype, curl, dom, gd, iconv, intl, json, ldap, mbstring, mcrypt, mysqlnd. opcache, openssl, pdo,  pgsql, phar, session, xml, xmlreader, zlib


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

This image assumes that you are using a reverse proxy such as [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) and optionally the [Let's Encrypt Proxy Companion @ https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion) or [tiredofit/traefik](https://github.com/tiredofit/docker-traefik) in order to serve your pages. However, it will run just fine on it's own if you map appropriate ports.

# Installation

Automated builds of the image are available on [Registry](https://hub.docker.com/tiredofit/nginx-php-fpm) and is the recommended method of installation.


```bash
docker pull hub.docker.com/tiredofit/nginx-php-fpm:(imagetag)
```

The following image tags are available:

* `7.3-latest` - PHP 7.3.x w/Alpine 3.11
* `edge-latest` - Most recent release of PHP w/most recent Alpine Linux
* `7.2-latest` - PHP 7.2.x w/Alpine 3.9
* `7.1-latest` - PHP 7.1.x w/Alpine 3.7
* `7.0-latest` - PHP 7.0.x w/Alpine 3.6
* `5.6-latest` - PHP 5.6.x w/Alpine 3.5
* `5.5-latest` - PHP 5.5.38 w/Alpine 3.4
* `5.3-latest` - PHP 5.3.29 w/Alpine 3.4

# Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

# Configuration

### Data-Volumes

The container starts up and reads from `/etc/nginx/nginx.conf` for some basic configuration and to listen on port 73 internally for Nginx Status responses. `/etc/nginx/conf.d` contains a sample configuration file that can be used to customize a nginx server block. 

The following directories are used for configuration and can be mapped for persistent storage.

| Directory | Description |
|-----------|-------------|
| `/www/html` | Root Directory |
| `/www/logs` | Nginx and php-fpm logfiles |

### Database

No Database Required - MariaDB Client is located within the image.

### Environment Variables

Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine) and the [Nginx Base](https://hub.docker.com/t/tiredofit/nginx), below is the complete list of available options that can be used to customize your installation.

*Container Options*

The container has an ability to work in 3 modes, `nginx-php-fpm` (default) is an All in One image with nginx and php-fpm working together, `nginx` will only utilize nginx however not the included php-fpm instance, allowing for connecting to multiple remote php-fpm backends, and finally `php-fpm` to operate PHP-FPM in standalone mode. 


| Parameter | Description |
|-----------|-------------|
| `CONTAINER_MODE` | Mode of running container `nginx-php-fpm`, `nginx`, `php-fpm` - Default `nginx-php-fpm` |

When `CONTAINER_MODE` set to `nginx` the `PHP_FPM_LISTEN_PORT` environment variable is ignored and the `PHP_FPM_HOST` variable defined below changes. You can add multiple PHP-FPM hosts to the backend in this syntax
<host>:<port> seperated by commas e.g.

    `php-fpm-container1:9000,php-fpm-container2:9000`

Note: You can also pass arguments to each server as defined in the [Nginx Upstream Documentation](https://nginx.org/en/docs/http/ngx_http_upstream_module.html)

| Parameter | Description |
|-----------|-------------|
| `PHP_APC_SHM_SIZE` | APC Cache Memory size - `0` to disable - Default `128M` |
| `PHP_FPM_HOST` | Default PHP-FPM Host - Default `127.0.0.1` - See above Container options |
| `PHP_FPM_LISTEN_PORT` | PHP-FPM Listening Port - Ignored with above container options - Default `9000` |
| `PHP_FPM_MAX_CHILDREN` | Maximum Children - Default `75` |
| `PHP_FPM_MAX_REQUESTS` | How many requests before spawning new server - Default `500` |
| `PHP_FPM_MAX_SPARE_SERVERS` | Maximum Spare Servers available- Default `3` |
| `PHP_FPM_MIN_SPARE_SERVERS` | Minium Spare Servers avaialble - Default `1` |
| `PHP_FPM_PROCESS_MANAGER` | How to handle processes `static`, `ondemand`, `dynamic` - Default `dynamic` |
| `PHP_FPM_START_SERVERS` | How many FPM servers to start initially - Default `2` |
| `PHP_LOG_FILE` | Logfile name - Default `php-fpm.log` |
| `PHP_LOG_LEVEL` | PHP Log Level - Default `notice` |
| `PHP_LOG_LOCATION` | Log Location for PHP Logs - Default `/www/logs/php-fpm` |
| `PHP_MEMORY_LIMIT` | How much memory should PHP use - Default `128M` |
| `PHP_OPCACHE_MEM_SIZE` | OPCache Memory Size - Set `0` to disable or via other env vars - Default `128` |
| `PHP_POST_MAX_SIZE` | Maximum Input Size for POST - Default `2G` |
| `PHP_TIMEOUT` | Maximum Script execution Time - Default `180` |
| `PHP_UPLOAD_MAX_SIZE` | Maximum Input Size for Uploads - Default `2G` |
| `PHP_WEBROOT` | Used with `CONTAINER_MODE=php-fpm` - Default `/www/html` |

*Enabling / Disabling Specific Extensions*
Extension variables are the same as the names of the PHP extensions

| Parameter | Description |
|-----------|-------------|
| `PHP_ENABLE_AMQP` | Default `FALSE` |
| `PHP_ENABLE_APCU` |  Default `TRUE` |
| `PHP_ENABLE_BCMATH` | Default `TRUE` |
| `PHP_ENABLE_BROTLI` | Default `FALSE` |
| `PHP_ENABLE_BZ2` | Default `FALSE` |
| `PHP_ENABLE_CALENDAR` | Default `FALSE` |
| `PHP_ENABLE_CREATE_SAMPLE_PHP` | Default `TRUE` |
| `PHP_ENABLE_CTYPE` | Default `TRUE` |
| `PHP_ENABLE_CURL` | Default `TRUE` |
| `PHP_ENABLE_DBA` | Default `FALSE` |
| `PHP_ENABLE_DISEVAL` | Default `FALSE` |
| `PHP_ENABLE_DISPLAY_ERRORS` | Default `TRUE` |
| `PHP_ENABLE_DOM` | Default `TRUE` |
| `PHP_ENABLE_EMBED` | Default `FALSE` |
| `PHP_ENABLE_ENCHANT` | Default `FALSE` |
| `PHP_ENABLE_EXIF` | Default `FALSE` |
| `PHP_ENABLE_FILEINFO` | Default `FALSE` |
| `PHP_ENABLE_FTP` | Default `FALSE` |
| `PHP_ENABLE_GD` | Default `TRUE` |
| `PHP_ENABLE_GEARMAN` | Default `FALSE` |
| `PHP_ENABLE_GETTEXT` | Default `FALSE` |
| `PHP_ENABLE_GMP` | Default `FALSE` |
| `PHP_ENABLE_ICONV` | Default `TRUE` |
| `PHP_ENABLE_IGBINARY` | Default `FALSE` |
| `PHP_ENABLE_IMAGICK` | Default `FALSE` |
| `PHP_ENABLE_IMAP` | Default `TRUE` |
| `PHP_ENABLE_INTL` | Default `TRUE` |
| `PHP_ENABLE_JSON` | Default `TRUE` |
| `PHP_ENABLE_LDAP` | Default `FALSE` |
| `PHP_ENABLE_MAILPARSE` | Default `FALSE` |
| `PHP_ENABLE_MBSTRING` | Default `TRUE` |
| `PHP_ENABLE_MCRYPT` | Default `TRUE` |
| `PHP_ENABLE_MEMCACHED` | Default `FALSE` |
| `PHP_ENABLE_MONGODB` | Default `FALSE` |
| `PHP_ENABLE_MYSQLI` | Default `TRUE` |
| `PHP_ENABLE_MYSQLND` | Default `TRUE` |
| `PHP_ENABLE_ODBC` | Default `FALSE` |
| `PHP_ENABLE_OPCACHE` | Default `TRUE` |
| `PHP_ENABLE_OPENSSL` | Default `TRUE` |
| `PHP_ENABLE_PCNTL` | Default `FALSE` |
| `PHP_ENABLE_PDO` | Default `TRUE` |
| `PHP_ENABLE_PDO_DBLIB` | Default `TRUE` |
| `PHP_ENABLE_PDO_MYSQL` | Default `FALSE` |
| `PHP_ENABLE_PDO_PGSQL` | Default `FALSE` |
| `PHP_ENABLE_PDO_ODBC` | Default `FALSE` |
| `PHP_ENABLE_PDO_SQLITE` | Default `FALSE` |
| `PHP_ENABLE_PGSQL` | Default `TRUE` |
| `PHP_ENABLE_PHAR` | Default `TRUE` |
| `PHP_ENABLE_POSIX` | Default `FALSE` |
| `PHP_ENABLE_PSPELL` | Default `FALSE` |
| `PHP_ENABLE_RECODE` | Default `FALSE` |
| `PHP_ENABLE_REDIS` | Default `FALSE` |
| `PHP_ENABLE_SESSION` | Default `TRUE` |
| `PHP_ENABLE_SHMOP` | Default `FALSE` |
| `PHP_ENABLE_SIMPLEXML` | Default `FALSE` |
| `PHP_ENABLE_SNMP` | Default `FALSE` |
| `PHP_ENABLE_SOAP` | Default `FALSE` |
| `PHP_ENABLE_SOCKETS` | Default `FALSE` |
| `PHP_ENABLE_SODIUM` | Default `FALSE` |
| `PHP_ENABLE_SPX` | Default `FALSE` |
| `PHP_ENABLE_SQLITE3` | Default `FALSE` |
| `PHP_ENABLE_TIDY` | Default `FALSE` |
| `PHP_ENABLE_TOKENIZER` | Default `FALSE` |
| `PHP_ENABLE_WDDX` | Default `FALSE` |
| `PHP_ENABLE_XDEBUG` | Default `FALSE` |
| `PHP_ENABLE_XML` | Default `TRUE` |
| `PHP_ENABLE_XMLREADER` | Default `TRUE` |
| `PHP_ENABLE_XMLRPC` | Default `FALSE` |
| `PHP_ENABLE_XMLWRITER` | Default `FALSE` |
| `PHP_ENABLE_ZIP` | Default `FALSE` |
| `PHP_ENABLE_ZLIB` | Default `TRUE` |
| `PHP_ENABLE_ZMQ` | Default `FALSE` |

If you enable `PHP_ENABLE_KITCHENSINK=TRUE` all extensions above will be enabled.

If enabling `PHP_ENABLE_XDEBUG`  the following are the environment variables are available. Visit the [PHP XDebug Documentation](https://xdebug.org/docs/all_settings#remote_connect_back) to understand what these options mean.

| Parameter | Description |
|-----------|-------------|
| `PHP_XDEBUG_PROFILER_DIR` |  Where to store Profiler Logs - Default `/www/logs/xdebug/` |
| `PHP_XDEBUG_PROFILER_ENABLE` | Enable Profiler - Default `0` |
| `PHP_XDEBUG_PROFILER_ENABLE_TRIGGER` | Enable Profiler Trigger - Default `0` | 
| `PHP_XDEBUG_REMOTE_AUTOSTART` | Enable Autostarting as opposed to GET/POST - Default `1` |
| `PHP_XDEBUG_REMOTE_CONNECT_BACK` | Enbable Connection Back - Default `0` |  
| `PHP_XDEBUG_REMOTE_ENABLE` | Enable Remote Debugging - Default `1` |
| `PHP_XDEBUG_REMOTE_HANDLER` | XDebug Remote Handler - Default `dbgp` |
| `PHP_XDEBUG_REMOTE_HOST` | Set this to your IP Address - Default `127.0.0.1` |
| `PHP_XDEBUG_REMOTE_PORT` | XDebug Remote Port - Default `9090` |

### Networking

The following ports are exposed.

| Port      | Description |
|-----------|-------------|
| `9000`  	| PHP-FPM     |

# Maintenance
#### Shell Access

If you wish to turn the web server into maintenance mode showing a single page screen outlining that the service is being worked on, you can also enter into the container and type `maintenance ARG`, where ARG is either `ON`,`OFF`, or `SLEEP (seconds)` which will temporarily place the site in maintenance mode and then restore it back to normal after time has passed. 

For debugging and maintenance purposes you may want access the containers shell. 

```bash
docker exec -it (whatever your container name is e.g. nginx-php-fpm) bash
```

# References

* https://www.nginx.org
* http://www.php.org
* https://xdebug.org

