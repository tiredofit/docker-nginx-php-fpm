## 3.9 2018-04-22 <dave at tiredofit dot ca>

* Tweak SMTP to always route through msmtp based on new Base Image Changes

## 3.8 2018-04-02 <dave at tiredofit dot ca>

* Added MAINTENANCE environment variable to move system to maintenance mode. Also maintenance script (off/on/sleep 60) inside container.

## 2018-03-18 3.7 <dave at tiredofit dot ca>

* Add `STAGE` variable to be passed to PHP for Development/Production Purposes

## 2018-02-20 3.6 <dave at tiredofit dot ca>

* Add Reverse Proxy Detection

## 2018-02-14 3.5 <dave at tiredofit dot ca>

* Remove Redundant Entrypoint
* Fix Paths for enabled php modules

## 2018-02-01 3.4 <dave at tiredofit dot ca>

* Fix PHP Timezone Issue

## 2017-01-29 3.3 <dave at tiredofit dot ca>

* Update Nginx to 1.13.8
* Update Zabbix Scripts

## 2017-12-01 3.21 <dave at tiredofit dot ca>

* Change Base to Alpine 3.7
* Nginx 1.13.7

## 2017-09-17 3.2 <dave at tiredofit dot ca>

* Fix Build Issues
* Nginx 1.13.5

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

