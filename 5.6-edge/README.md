# hub.docker.com/tiredofit/nginx-php-fpm

# Introduction

Dockerfile to build a [Nginx](https://www.nginx.org) w/[PHP-FPM](https://php.net) container image.

* This Container uses Alpine as a base which includes [s6 overlay](https://github.com/just-containers/s6-overlay) enabled for PID 1 Init capabilities, [zabbix-agent](https://zabbix.org) based on 3.4 Packages for individual container monitoring, Cron also installed along with other tools (bash,curl, less, logrotate, mariadb-client, nano, vim) for easier management.
* Ability to Password Protect (Basic) or use LemonLDAP:NG Handler
* Caching is provided with w/ APC, OpCache
* PHP Extensions included are: 
         php5-apcu, 
          php5-bcmath, 
          php5-ctype, 
          php5-curl, 
          php5-dom, 
          php5-fpm, 
          php5-gd, 
          php5-iconv, 
          php5-intl, 
          php5-json, 
          php5-ldap, 
          php5-mcrypt, 
          php5-mysqli, 
          php5-opcache, 
          php5-openssl, 
          php5-pdo, 
          php5-pdo_mysql, 
          php5-phar\
          php5-xml, 
          php5-xmlreader, 
          php5-zlib



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

This image assumes that you are using a reverse proxy such as [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) and optionally the [Let's Encrypt Proxy Companion @ https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion) in order to serve your pages. However, it will run just fine on it's own if you map appropriate ports.



# Installation

Automated builds of the image are available on [Registry](https://hub.docker.com/tiredofit/nginx-php-fpm) and is the recommended method of installation.


```bash
docker pull hub.docker.com/tiredofit/nginx-php-fpm:(imagetag)
```

The following image tags are available:

* `5.3-latest` - PHP 5.3.29 w/Alpine 3.4 - Limited Extensions - No Xdebug
* `5.5-latest` - PHP 5.5..38 w/Alpine 3.4 - Limited Extensions - No Xdebug
* `5.6-latest` - PHP 5.6.x w/Alpine 3.4 - No XDebug
* `7.0-latest` - PHP 7.0.x w/Alpine 3.5
* `7.1-latest` - PHP 7.1.x w/Alpine 3.6
* `7.1-ldap-latest` - PHP 7.1.x w/LDAP Authentication w/Alpine 3.6
* `latest` - Most recent release of PHP w/most recent Alpine Linux

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

Along with the Environment Variables from the Base image, below is the complete list of available options 
that can be used to customize your installation.

Authentication Options

| Parameter | Description |
|-----------|-------------|
| `AUTHENTICATION_TYPE` | Protect site - `NONE`,`BASIC`,`LLNG` - Default `NONE` |
| `WEB_USER` | If `BASIC` chosen enter this for the username to protect site |
| `WEB_PASS` | If `BASIC` chosen enter this for the password to protect site |
| `LLNG_HANDLER_HOST` | If `LLNG` chosen use hostname of handler - Default `llng-handler`
| `LLNG_HANDLER_PORT` | If `LLNG` chosen use this port for handler - Default `2884` |

The `LLNG` option is for when using LemonLDAP:NG Handlers to protect your application and require modification to the `/etc/nginx/conf.d/default.llng` file to fully work properly! 

General Options 

| Parameter | Description |
|-----------|-------------|
| `PHP_MEMORY_LIMIT` |Amount of memory php-fpm process should use (Default `128M`) |
| `PHP_LOG_LEVEL` | Define verbosity: (e.g `debug`, `info`, `notice`, `warning`, `error`, `critical`, and `alert` - Default `info`)
| `PHP_TIMEOUT`   | Sets Read and Write Timeouts for Nginx FastCGI (Default `300`) |
| `UPLOAD_MAX_SIZE` | Maximum Upload Size: (Default `2G`) |
| `APC_SHM_SIZE` | PHP5 APC SHM Cache Size: (Default `128M`) |
| `OPCACHE_MEM_SIZE` | PHP5 OPCache Size - Select `0` to Disable (Default `128`) |
| `TZ` | Timezone - Use Unix Timezone format (Default `America/Vancouver`) |

Enable/Disable Extensions as follows:

Enabling / Disabling Specific Extensions

| Parameter | Description |
|-----------|-------------|
| `PHP_ENABLE_APCU` |  apcu extension - Default `TRUE` |
| `PHP_ENABLE_BCMATH` | bcmath extension - Default `TRUE` |
| `PHP_ENABLE_BZ2` | bzip2 extension - Default `FALSE` |
| `PHP_ENABLE_CALENDAR` | calendar extension - Default `FALSE` |
| `PHP_ENABLE_CTYPE` | ctype extension - Default `TRUE` |
| `PHP_ENABLE_CURL` | curl extension - Default `TRUE` |
| `PHP_ENABLE_DBA` | dba extension - Default `FALSE` |
| `PHP_ENABLE_DOM` | dom extension - Default `TRUE` |
| `PHP_ENABLE_EMBED` | embed extension - Default `FALSE` |
| `PHP_ENABLE_ENCHANT` | enchant extension - Default `FALSE` |
| `PHP_ENABLE_EXIF` | EXIF extension - Default `FALSE` |
| `PHP_ENABLE_FTP` | FTP extension - Default `FALSE` |
| `PHP_ENABLE_GD` | GD extension - Default `TRUE` |
| `PHP_ENABLE_GETTEXT` | gettext extension - Default `FALSE` |
| `PHP_ENABLE_GMP` |  gmp extension - Default `FALSE` |
| `PHP_ENABLE_ICONV` | iconv extension - Default `TRUE` |
| `PHP_ENABLE_IMAP` | IMAP extension - Default `TRUE` |
| `PHP_ENABLE_INTL` | INTL extension - Default `TRUE` |
| `PHP_ENABLE_JSON` | JSON extension - Default `TRUE` |
| `PHP_ENABLE_LDAP` | LDAP extension - Default `TRUE` |
| `PHP_ENABLE_MAILPARSE` | MAILPARSE extension - Default `FALSE` |
| `PHP_ENABLE_MBSTRING` | mbstring extension - Default `TRUE` |
| `PHP_ENABLE_MCRYPT` | mcrypt extension - Default `TRUE` |
| `PHP_ENABLE_ODBC` |  ODBC extension - Default `FALSE` |
| `PHP_ENABLE_OPCACHE` | OPCACHE extension - Default `TRUE` |
| `PHP_ENABLE_OPENSSL` | OpenSSL extension - Default `TRUE` |
| `PHP_ENABLE_PCNTL` | PCNTL extension - Default `FALSE` |
| `PHP_ENABLE_PDO` | PDO extension - Default `TRUE` |
| `PHP_ENABLE_PDO_MYSQL` | PDO_MySQL extension - Default `TRUE` |
| `PHP_ENABLE_PDO_PGSQL` | PDO_PGSQL extension - Default `FALSE` |
| `PHP_ENABLE_PDO_SQLITE` | PDO_SQLITE3 extension - Default `TRUE` |
| `PHP_ENABLE_PGSQL` | PGSQL extension - Default `TRUE` |
| `PHP_ENABLE_PHAR` | PHAR extension - Default `TRUE` |
| `PHP_ENABLE_POSIX` | POSIX extension - Default `FALSE` |
| `PHP_ENABLE_PSPELL` | pspell extension - Default `FALSE` |
| `PHP_ENABLE_SHMOP` | SHMOP extension - Default `FALSE` |
| `PHP_ENABLE_SNMP` | SNMP extension - Default `FALSE` |
| `PHP_ENABLE_SOAP` | SOAP extension - Default `FALSE` |
| `PHP_ENABLE_WDDX` | WDDX extension - Default `FALSE` |
| `PHP_ENABLE_XML` | XML extension - Default `TRUE` |
| `PHP_ENABLE_XMLREADER` | XMLReader extension - Default `TRUE` |
| `PHP_ENABLE_XMLRPC` | XMLRPC extension - Default `FALSE` |
| `PHP_ENABLE_ZIP` | ZIP extension - Default `FALSE` |
| `PHP_ENABLE_ZLIB` | Zlib extension - Default `TRUE` |

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

