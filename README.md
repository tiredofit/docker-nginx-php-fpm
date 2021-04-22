# hub.docker.com/r/tiredofit/nginx-php-fpm

[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/nginx-php-fpm.svg)](https://hub.docker.com/r/tiredofit/nginx-php-fpm)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/nginx-php-fpm.svg)](https://hub.docker.com/r/tiredofit/nginx-php-fpm)
[![Docker
Layers](https://images.microbadger.com/badges/image/tiredofit/nginx-php-fpm.svg)](https://microbadger.com/images/tiredofit/nginx-php-fpm)


# Introduction

Dockerfile to build a [Nginx](https://www.nginx.org) w/[PHP-FPM](https://php.net) container image.

* This Container uses a customized [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) or [Debian Linux](https://hub.docker.com/r/tiredofit/debian) which includes [s6 overlay](https://github.com/just-containers/s6-overlay) enabled for PID 1 Init capabilities, [zabbix-agent](https://zabbix.org) for individual container monitoring, Cron also installed along with other tools (bash,curl, less, logrotate, mariadb-client, nano, vim) for easier management. It also supports sending to external SMTP servers..
* Debug Mode to Enable XDebug
* Caching is provided with w/ APC, OpCache
* Enabled by default extensions are: apcu, bcmath, ctype, curl, dom, gd, iconv, intl, json, ldap, mbstring, mcrypt, mysqlnd. opcache, pdo,  pgsql, phar, session, tokenizer, xml, xmlreader

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

* `edge-latest` - Most recent release of PHP w/most recent Alpine Linux
* `8.0-latest` - PHP 7.3.x w/Alpine 3.13
* `7.4-latest` - PHP 7.3.x w/Alpine 3.13
* `7.3-latest` - PHP 7.3.x w/Alpine 3.12
* `7.2-latest` - PHP 7.2.x w/Alpine 3.9
* `7.1-latest` - PHP 7.1.x w/Alpine 3.7
* `7.0-latest` - PHP 7.0.x w/Alpine 3.6
* `5.6-latest` - PHP 5.6.x w/Alpine 3.5
* `5.5-latest` - PHP 5.5.38 w/Alpine 3.4
* `5.3-latest` - PHP 5.3.29 w/Alpine 3.4
* `debian-8.0` - PHP 7.4 w/Debian Buster
* `debian-7.4` - PHP 7.4 w/Debian Buster
* `debian-7.3` - PHP 7.3 w/Debian Buster

# Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

# Configuration

### Data-Volumes

The container starts up and reads from `/etc/nginx/nginx.conf` for some basic configuration and to listen on port 73 internally for Nginx Status responses. `/etc/nginx/conf.d` contains a sample configuration file that can be used to customize a nginx server block.

The following directories are used for configuration and can be mapped for persistent storage.

| Directory   | Description                |
| ----------- | -------------------------- |
| `/www/html` | Root Directory             |
| `/www/logs` | Nginx and php-fpm logfiles |

### Database

No Database Required - MariaDB Client is located within the image.

### Environment Variables

Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine) and the [Nginx Base](https://hub.docker.com/r/tiredofit/nginx), below is the complete list of available options that can be used to customize your installation.

*Container Options*

The container has an ability to work in 3 modes, `nginx-php-fpm` (default) is an All in One image with nginx and php-fpm working together, `nginx` will only utilize nginx however not the included php-fpm instance, allowing for connecting to multiple remote php-fpm backends, and finally `php-fpm` to operate PHP-FPM in standalone mode.


| Parameter        | Description                                                   | Default         |
| ---------------- | ------------------------------------------------------------- | --------------- |
| `CONTAINER_MODE` | Mode of running container `nginx-php-fpm`, `nginx`, `php-fpm` | `nginx-php-fpm` |

When `CONTAINER_MODE` set to `nginx` the `PHP_FPM_LISTEN_PORT` environment variable is ignored and the `PHP_FPM_HOST` variable defined below changes. You can add multiple PHP-FPM hosts to the backend in this syntax
<host>:<port> seperated by commas e.g.

    `php-fpm-container1:9000,php-fpm-container2:9000`

Note: You can also pass arguments to each server as defined in the [Nginx Upstream Documentation](https://nginx.org/en/docs/http/ngx_http_upstream_module.html)

| Parameter                   | Description                                                    | Default                                   |
| --------------------------- | -------------------------------------------------------------- | ----------------------------------------- |
| `PHP_APC_SHM_SIZE`          | APC Cache Memory size - `0` to disable                         | `128M`                                    |
| `PHP_FPM_HOST`              | Default PHP-FPM Host                                           | `127.0.0.1` - See above Container options |
| `PHP_FPM_LISTEN_PORT`       | PHP-FPM Listening Port - Ignored with above container options  | `9000`                                    |
| `PHP_FPM_MAX_CHILDREN`      | Maximum Children                                               | `75`                                      |
| `PHP_FPM_MAX_REQUESTS`      | How many requests before spawning new server                   | `500`                                     |
| `PHP_FPM_MAX_SPARE_SERVERS` | Maximum Spare Servers available                                | `3`                                       |
| `PHP_FPM_MIN_SPARE_SERVERS` | Minium Spare Servers avaialble                                 | `1`                                       |
| `PHP_FPM_PROCESS_MANAGER`   | How to handle processes `static`, `ondemand`, `dynamic`        | `dynamic`                                 |
| `PHP_FPM_START_SERVERS`     | How many FPM servers to start initially                        | `2`                                       |
| `PHP_LOG_FILE`              | Logfile name                                                   | `php-fpm.log`                             |
| `PHP_LOG_LEVEL`             | PHP Log Level                                                  | `notice`                                  |
| `PHP_LOG_LOCATION`          | Log Location for PHP Logs                                      | `/www/logs/php-fpm`                       |
| `PHP_MEMORY_LIMIT`          | How much memory should PHP use                                 | `128M`                                    |
| `PHP_OPCACHE_MEM_SIZE`      | OPCache Memory Size - Set `0` to disable or via other env vars | `128`                                     |
| `PHP_POST_MAX_SIZE`         | Maximum Input Size for POST                                    | `2G`                                      |
| `PHP_TIMEOUT`               | Maximum Script execution Time                                  | `180`                                     |
| `PHP_UPLOAD_MAX_SIZE`       | Maximum Input Size for Uploads                                 | `2G`                                      |
| `PHP_WEBROOT`               | Used with `CONTAINER_MODE=php-fpm`                             | `/www/html`                               |

*Enabling / Disabling Specific Extensions*
Enable extensions by using the PHP extension name ie redis as `PHP_ENABLE_REDIS=TRUE`. Core extensions are enabled by default are:

| Parameter              | Description     |
| ---------------------- | --------------- |
| `PHP_ENABLE_APCU`      | Default Enabled |
| `PHP_ENABLE_BCMATH`    | Default Enabled |
| `PHP_ENABLE_BZ2`       | Default Enabled |
| `PHP_ENABLE_CTYPE`     | Default Enabled |
| `PHP_ENABLE_CURL`      | Default Enabled |
| `PHP_ENABLE_DOM`       | Default Enabled |
| `PHP_ENABLE_EXIF`      | Default Enabled |
| `PHP_ENABLE_FILEINFO`  | Default Enabled |
| `PHP_ENABLE_GD`        | Default Enabled |
| `PHP_ENABLE_ICONV`     | Default Enabled |
| `PHP_ENABLE_IMAP`      | Default Enabled |
| `PHP_ENABLE_INTL`      | Default Enabled |
| `PHP_ENABLE_JSON`      | Default Enabled |
| `PHP_ENABLE_MBSTRING`  | Default Enabled |
| `PHP_ENABLE_MYSQLI`    | Default Enabled |
| `PHP_ENABLE_MYSQLND`   | Default Enabled |
| `PHP_ENABLE_OPCACHE`   | Default Enabled |
| `PHP_ENABLE_PDO`       | Default Enabled |
| `PHP_ENABLE_PDO_MYSQL` | Default Enabled |
| `PHP_ENABLE_PGSQL`     | Default Enabled |
| `PHP_ENABLE_PHAR`      | Default Enabled |
| `PHP_ENABLE_SIMPLEXML` | Default Enabled |
| `PHP_ENABLE_TOKENIZER` | Default Enabled |
| `PHP_ENABLE_XML`       | Default Enabled |
| `PHP_ENABLE_XMLREADER` | Default Enabled |
| `PHP_ENABLE_XMLWRITER` | Default Enabled |

If you enable `PHP_KITCHENSINK=TRUE` all extensions in the image will be enabled. Head inside the image and see what extensions are available by typing `php-ext list all`

If enabling PHP_ENABLE_XDEBUG=TRUE` the following are the environment variables are available. Visit the [PHP XDebug Documentation](https://xdebug.org/docs/all_settings#remote_connect_back) to understand what these options mean.

| Parameter                            | Description                                |
| ------------------------------------ | ------------------------------------------ |
| `PHP_XDEBUG_PROFILER_DIR`            | Where to store Profiler Logs               | `/www/logs/xdebug/` |
| `PHP_XDEBUG_PROFILER_ENABLE`         | Enable Profiler                            | `0`                 |
| `PHP_XDEBUG_PROFILER_ENABLE_TRIGGER` | Enable Profiler Trigger                    | `0`                 |
| `PHP_XDEBUG_REMOTE_AUTOSTART`        | Enable Autostarting as opposed to GET/POST | `1`                 |
| `PHP_XDEBUG_REMOTE_CONNECT_BACK`     | Enbable Connection Back                    | `0`                 |
| `PHP_XDEBUG_REMOTE_ENABLE`           | Enable Remote Debugging                    | `1`                 |
| `PHP_XDEBUG_REMOTE_HANDLER`          | XDebug Remote Handler                      | `dbgp`              |
| `PHP_XDEBUG_REMOTE_HOST`             | Set this to your IP Address                | `127.0.0.1`         |
| `PHP_XDEBUG_REMOTE_PORT`             | XDebug Remote Port                         | `9090`              |

### Networking

The following ports are exposed.

| Port   | Description |
| ------ | ----------- |
| `9000` | PHP-FPM     |

# Maintenance

#### Shell Access
For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is e.g. nginx-php-fpm) bash
```
#### PHP Extensions
If you want to enable or disable PHP Extensions, type `php-ext help` to get information on how to enable, disable, or list available extensions in the image.
#### Maintenance Mode
If you wish to turn the web server into maintenance mode showing a single page screen outlining that the service is being worked on, you can also enter into the container and type `maintenance ARG`, where ARG is either `ON`,`OFF`, or `SLEEP (seconds)` which will temporarily place the site in maintenance mode and then restore it back to normal after time has passed.


# References

* https://www.nginx.org
* http://www.php.org
* https://xdebug.org
