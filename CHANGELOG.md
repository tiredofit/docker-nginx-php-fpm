## 6.1.12 2021-05-25 <dave at tiredofit dot ca>

   ### Changed
      - Additional checks for msmtp usage - If ENABLE_SMTP=FALSE then don't execute permissions settings


## 6.1.11 2021-05-25 <dave at tiredofit dot ca>

   ### Changed
      - Change the way that LLNG authentication gets loaded


## 6.1.10 2021-05-24 <dave at tiredofit dot ca>

   ### Changed
      - Fix for 6.1.9 permissions


## 6.1.9 2021-05-24 <dave at tiredofit dot ca>

   ### Changed
      - Update msmtprc file with nginx user/group permissions to allow php-fpm to send
      - Shuffle XDebug environment variables and configuraiton around


## 6.1.8 2021-05-19 <dave at tiredofit dot ca>

   ### Added
      - Add gpgme package (Alpine)

   ### Changed
      - Fix for php-ext enable script to stop loading json if PHP > 8
      - GPG extension loading fix


## 6.1.7 2021-05-05 <dave at tiredofit dot ca>

   ### Changed
      - Force OPENSSL extension to be activated by default to fix composer errors


## 6.1.6 2021-05-04 <dave at tiredofit dot ca>

   ### Changed
      - Fix for opcache being loaded twice in some scenarios


## 6.1.5 2021-05-03 <dave at tiredofit dot ca>

   ### Changed
      - Fix for enabling json warning under php8


## 6.1.4 2021-05-03 <dave at tiredofit dot ca>

   ### Changed
      - Fix for JSON for <php7


## 6.1.3 2021-05-03 <dave at tiredofit dot ca>

   ### Changed
      - Add PHP_ENABLE_SESSION=TRUE to defaults
      - Set PHP_ENABLE_IGBINARY=TRUE when PHP_ENABLE_REDIS=TRUE


## 6.1.2 2021-05-01 <dave at tiredofit dot ca>

   ### Changed
      - Fixes to php extension script specifically under Alpine


## 6.1.1 2021-05-01 <dave at tiredofit dot ca>

   ### Changed
      - Fix for determining PHP version on runtime


## 6.1.0 2021-04-22 <dave at tiredofit dot ca>

   ### Changed
      - Unified Script for Alpine and Debian
      - Merged all changes up to 6.xx into Alpine build

## 6.0.1 2021-04-16 <dave at tiredofit dot ca>

   ### Changed
      - Fix PHP Extension script
      - Opcache seems to want to load twice for some reason, dirty hack enabled
      - Composer wasn't installing properly


## 6.0.0 2021-04-16 <dave at tiredofit dot ca>

   ### Added
      - Merged Debian branches into one - Use Build Argument of PHP_BASE to build `7.3` `7.4` or `8.0`
      - Composer 2.x
      - Massively revamped module loading. Try `php-env` from the command line to enable, disable, see modules available per version
      - Building for Stretch and Buster, ready for Bullseye
      - Building and amd64, arm7, arm64

## 5.6.0 2020-10-26 <dave at tiredofit dot ca>

   ### Added
      - Add composer version declaration (pinning to 1.10.16)


## 5.5.3 2020-08-29 <dave at tiredofit dot ca>

   ### Added
      - Add ENABLE_PHP_FPM environment variable


## 5.5.2 2020-08-10 <dave at tiredofit dot ca>

   ### Changed
      - Fix to regex for LLNG Authentication


## 5.5.1 2020-07-16 <dave at tiredofit dot ca>

   ### Changed
      - Fix logrotate for PHP-FPM


## 5.5.0 2020-06-09 <dave at tiredofit dot ca>

   ### Added
      - Update to support tiredofit/debian 5.0.0 base image


## 5.4.1 2020-06-05 <dave at tiredofit dot ca>

   ### Changed
      - Move /etc/s6/services to /etc/services.d


## 5.4.0 2020-05-13 <dave at tiredofit dot ca>

   ### Added
      - PHP 7.3 - Debian Buster Variant


## 5.3.7 2020-04-21 <dave at tiredofit dot ca>

   ### Changed
      - Remove extra logrotate.d file added by packages


## 5.3.6 2020-04-21 <dave at tiredofit dot ca>

   ### Changed
      - Fix for PHP Plugins not enabling correctly


## 5.3.5 2020-04-18 <dave at tiredofit dot ca>

   ### Added
      - Update to support tiredofit/alpine 4.5.1 base image


## 5.3.4 2020-03-16 <dave at tiredofit dot ca>

   ### Changed
      - Change msmtp configuration


## 5.3.3 2020-03-04 <dave at tiredofit dot ca>

   ### Added
      - Update image to support new tiredofit/alpine:4.4.0 base image

## 5.3.1 2020-01-20 <dave at tiredofit dot ca>

   ### Changed
      - Change the way PHP XDebug is being called


## 5.3.0 2020-01-04 <dave at tiredofit dot ca>

   ### Added
      - Add new `CONTAINER_MODE` environment variable to allow standalone operation for load balancing
      - Add new `PHP_WEBROOT` environment variable when `CONTAINER_MODE` set to `php-fpm`


## 5.2.2 2020-01-03 <dave at tiredofit dot ca>

   ### Added
      - ADD PHP_POST_MAX_SIZE environment variable

   ### Changed
      - Cleanup with LLNG Authentication
      - Properly assign PHP_UPLOAD_MAX_SIZE and PHP_POST_MAX_SIZE variables


## 5.2.0 2019-12-31 <dave at tiredofit dot ca>

   ### Added
      - Move defaults to /assets/functions files

   ### Changed
      - Change warnings to notices


## 5.1.0 2019-12-29 <dave at tiredofit dot ca>

   ### Added
      - Update to support new tiredofit/alpine base image


## 5.0.4 2019-12-19 <dave at tiredofit dot ca>

   ### Changed
      - Change to LLNG Authentication Auto Configuration Routines


## 5.0.3 2019-12-18 <dave at tiredofit dot ca>

   ### Changed
      - Fixed error with display errors configuration

## 5.0.2 2019-12-18 <dave at tiredofit dot ca>

   ### Changed
      - Change to support dynamic webserver user/group


## 5.0.1 2019-12-04 <dave at tiredofit dot ca>

   ### Changed
      - Make MySQL Default Enabled


## 5.0.0 2019-12-04 <dave at tiredofit dot ca>

   ### Added
      - Reworked entire image
      - Added many new variables
      - Basing off of tiredofit/nginx
      - Code Cleanup


## 4.4.2 2019-11-18 <dave at tiredofit dot ca>

   ### Changed
      - Update Nginx proxy temp location


## 4.4.1 2019-07-08 <dave at tiredofit dot ca>

* Add tmp folder during startup to avoid bootloop

## 4.4 2019-06-19 <dave at tiredofit dot ca>

* PHP 7.3
* Alpine 3.10

## 4.3 2019-03-03 <dave at tiredofit dot ca>

* Move Alpine base to 3.9

## 4.2 2018-12-17 <dave at tiredofit dot ca>

* Add Nginx tmp cache directory

## 4.1 2018-11-28 <dave at tiredofit dot ca>

* Fix Timezone setting for php.ini

## 4.0.1 2018-11-19 <dave at tiredofit dot ca>

* Update further LLNG

## 4.0 2018-04-28 <dave at tiredofit dot ca>

* Ability to protect service via basic authentication or using LemonLDAP:NG Handlers


## 3.7 2018-04-22 <dave at tiredofit dot ca>

* Tweak SMTP to always route through msmtp based on new Base Image Changes

## 3.6 2018-04-02 <dave at tiredofit dot ca>

* Added MAINTENANCE environment variable to move system to maintenance mode. Also maintenance script (off/on/sleep 60) inside container.

## 2018-03-18 3.5 <dave at tiredofit dot ca>

* Add `STAGE` variable to be passed to PHP for Development/Production Purposes

## 2018-02-20 3.4 <dave at tiredofit dot ca>

* Add Reverse Proxy Detection

## 2018-02-14 3.3 <dave at tiredofit dot ca>

* Remove Redundant Entrypoint
* Fix Paths for enabled php modules

## 2018-02-01 3.2 <dave at tiredofit dot ca>

* Fix PHP Timezone Issue
* Add Zabbix Scripts

## 2017-11-30 edge-3.1 <dave at tiredofit dot ca>

* Switched to Edge Base


## 2017-09-17 3.1 <dave at tiredofit dot ca>

* Fix Issue with PHP XDebug
* Added Imagick Extension

## 2017-08-27 3.0 <dave at tiredofit dot ca>

* Big change (in image size) due to adding all available PHP Extensions
* Debug Mode via XDebug set via Environment Variables
* All PHP Extensions able to be enabled of disabled via Environment Variables

## 2017-07-12 2.6 <dave at tiredofit dot ca>

* Added Checking to wait to start services in sequence

## 2017-07-12 2.5 <dave at tiredofit dot ca>

* Added Composer, memcached, and sqlite extensions

## 2017-07-06 2.4 <dave at tiredofit dot ca>

* Added proper logging for php-fpm

## 2017-07-06 2.3 <dave at tiredofit dot ca>

* Add PHP_TIMEOUT

## 2017-07-03 2.2 <dave at tiredofit dot ca>

* Added Logrotate

## 2017-07-01 2.1 <dave at tiredofit dot ca>

* Sanity Check and write initialization state to /tmp/state/*service name
* Added MSMTP to take place of sendmail


## 2017-06-23 2.0 <dave at tiredofit dot ca>

* s6.d Process Seperation
* PHP-FPM run as NGINX
* Nginx Zabbix Checks set to port 73
* Nginx Uses conf.d file for Loading Site


## 2017-05-29 1.3 <dave at tiredofit dot ca>

* Tracking Alpine 3.4
* PHP 5.6

## 2017-04-07 1.2 <dave at tiredofit dot ca>

* Rebase

## 2017-02-08 1.1 <dave at tiredofit dot ca>

* Added mariadb-client

## 2017-02-08 1.0 <dave at tiredofit dot ca>

* Initial Release
* Alpine:edge
* PHP7
* Zabbix

