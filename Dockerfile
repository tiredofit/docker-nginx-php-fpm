FROM tiredofit/nginx:alpine-3.13
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

ARG PHP_BASE

ENV PHP_BASE=${PHP_BASE:-"7.4"} \
    PHP_ENABLE_APCU=TRUE \
    PHP_ENABLE_BCMATH=TRUE \
    PHP_ENABLE_BZ2=TRUE \
    PHP_ENABLE_CTYPE=TRUE \
    PHP_ENABLE_CURL=TRUE \
    PHP_ENABLE_DOM=TRUE \
    PHP_ENABLE_EXIF=TRUE \
    PHP_ENABLE_FILEINFO=TRUE \
    PHP_ENABLE_GD=TRUE \
    PHP_ENABLE_ICONV=TRUE \
    PHP_ENABLE_IMAP=TRUE \
    PHP_ENABLE_INTL=TRUE \
    PHP_ENABLE_MBSTRING=TRUE \
    PHP_ENABLE_MYSQLI=TRUE \
    PHP_ENABLE_MYSQLND=TRUE \
    PHP_ENABLE_OPCACHE=TRUE \
    PHP_ENABLE_OPENSSL=TRUE \
    PHP_ENABLE_PDO=TRUE \
    PHP_ENABLE_PDO_MYSQL=TRUE \
    PHP_ENABLE_PGSQL=TRUE \
    PHP_ENABLE_PHAR=TRUE \
    PHP_ENABLE_SESSION=TRUE \
    PHP_ENABLE_SIMPLEXML=TRUE \
    PHP_ENABLE_TOKENIZER=TRUE \
    PHP_ENABLE_XML=TRUE \
    PHP_ENABLE_XMLREADER=TRUE \
    PHP_ENABLE_XMLWRITER=TRUE \
    ZABBIX_HOSTNAME=nginx-php-fpm-app \
    ENABLE_SMTP=TRUE \
    NGINX_ENABLE_CREATE_SAMPLE_HTML=FALSE

### Dependency Installation
RUN export PHP_8_0_RUN_DEPS=" \
                            php8  \
                            php8-bcmath  \
                            php8-brotli \
                            php8-bz2  \
                            php8-calendar  \
                            php8-common  \
                            php8-ctype  \
                            php8-curl  \
                            php8-dba  \
                            php8-dom  \
                            php8-embed  \
                            php8-enchant  \
                            php8-exif  \
                            php8-ffi  \
                            php8-fileinfo  \
                            php8-fpm  \
                            php8-ftp  \
                            php8-gd  \
                            php8-gettext  \
                            php8-gmp  \
                            php8-iconv  \
                            php8-imap  \
                            php8-intl  \
                            php8-ldap  \
                            php8-mbstring  \
                            php8-mysqli  \
                            php8-mysqlnd  \
                            php8-odbc  \
                            php8-opcache  \
                            php8-openssl  \
                            php8-pcntl  \
                            php8-pdo  \
                            php8-pdo_dblib  \
                            php8-pdo_mysql  \
                            php8-pdo_odbc  \
                            php8-pdo_pgsql  \
                            php8-pdo_sqlite  \
                            php8-pear  \
                            php8-pecl-apcu \
                            php8-pecl-ast \
                            php8-pecl-event \
                            php8-pecl-igbinary \
                            php8-pecl-imagick \
                            php8-pecl-lzf \
                            php8-pecl-mailparse \
                            php8-pecl-maxminddb \
                            php8-pecl-mcrypt \
                            php8-pecl-memcache \
                            php8-pecl-memcached \
                            php8-pecl-mongodb \
                            php8-pecl-msgpack \
                            php8-pecl-oauth \
                            php8-pecl-redis \
                            php8-pecl-timezonedb \
                            php8-pecl-uploadprogress \
                            php8-pecl-uuid \
                            php8-pecl-vips \
                            php8-pecl-xdebug \
                            php8-pecl-xhprof \
                            php8-pecl-yaml \
                            php8-pgsql  \
                            php8-phar  \
                            php8-posix  \
                            php8-pspell  \
                            php8-session  \
                            php8-shmop  \
                            php8-simplexml  \
                            php8-snmp  \
                            php8-soap  \
                            php8-sockets  \
                            php8-sodium  \
                            php8-sqlite3  \
                            php8-tidy  \
                            php8-tokenizer  \
                            php8-xml  \
                            php8-xmlreader  \
                            php8-xmlwriter  \
                            php8-xsl  \
                            php8-zip  \
                            " && \
    \
    export PHP_7_4_RUN_DEPS=" \
                            php7 \
                            php7-bcmath \
                            php7-brotli \
                            php7-bz2 \
                            php7-calendar \
                            php7-common \
                            php7-ctype \
                            php7-curl \
                            php7-dba \
                            php7-dom \
                            php7-embed \
                            php7-enchant \
                            php7-exif \
                            php7-ffi \
                            php7-fileinfo \
                            php7-fpm \
                            php7-ftp \
                            php7-gd \
                            php7-gettext \
                            php7-gmp \
                            php7-iconv \
                            php7-imap \
                            php7-intl \
                            php7-json \
                            php7-ldap \
                            php7-mbstring \
                            php7-mysqli \
                            php7-mysqlnd \
                            php7-odbc \
                            php7-opcache \
                            php7-openssl \
                            php7-pcntl \
                            php7-pdo \
                            php7-pdo_dblib \
                            php7-pdo_mysql \
                            php7-pdo_odbc \
                            php7-pdo_pgsql \
                            php7-pdo_sqlite \
                            php7-pear \
                            php7-pecl-amqp \
                            php7-pecl-apcu \
                            php7-pecl-ast \
                            php7-pecl-couchbase \
                            php7-pecl-event \
                            php7-pecl-gmagick \
                            php7-pecl-imagick \
                            php7-pecl-igbinary \
                            php7-pecl-lzf \
                            php7-pecl-mailparse \
                            php7-pecl-maxminddb \
                            php7-pecl-mcrypt \
                            php7-pecl-memcache \
                            php7-pecl-memcached \
                            php7-pecl-mongodb \
                            php7-pecl-msgpack \
                            php7-pecl-oauth \
                            php7-pecl-protobuf \
                            php7-pecl-psr \
                            php7-pecl-redis \
                            php7-pecl-ssh2 \
                            php7-pecl-timezonedb \
                            php7-pecl-uploadprogress \
                            php7-pecl-uuid \
                            php7-pecl-vips \
                            php7-pecl-xdebug \
                            php7-pecl-xhprof \
                            php7-pecl-xhprof-assets \
                            php7-pecl-yaml \
                            php7-pecl-zmq \
                            php7-pgsql \
                            php7-phalcon \
                            php7-phar \
                            php7-phpdbg \
                            php7-posix \
                            php7-pspell \
                            php7-session \
                            php7-shmop \
                            php7-simplexml \
                            php7-snmp \
                            php7-soap \
                            php7-sockets \
                            php7-sodium \
                            php7-sqlite3 \
                            php7-tidy \
                            php7-tokenizer \
                            php7-xml \
                            php7-xmlreader \
                            php7-xmlrpc \
                            php7-xmlwriter \
                            php7-xsl \
                            php7-zip \
                            " && \
    \
    export PHP_7_3_RUN_DEPS=" \
                            php7 \
                            php7-bcmath \
                            php7-brotli \
                            php7-bz2 \
                            php7-calendar \
                            php7-common \
                            php7-ctype \
                            php7-curl \
                            php7-dba \
                            php7-dbg \
                            php7-dom \
                            php7-embed \
                            php7-enchant \
                            php7-exif \
                            php7-fileinfo \
                            php7-fpm \
                            php7-ftp \
                            php7-gd \
                            php7-gettext \
                            php7-gmp \
                            php7-iconv \
                            php7-imap \
                            php7-intl \
                            php7-json \
                            php7-ldap \
                            php7-litespeed \
                            php7-maxminddb \
                            php7-mbstring \
                            php7-mysqli \
                            php7-mysqlnd \
                            php7-odbc \
                            php7-opcache \
                            php7-openssl \
                            php7-pcntl \
                            php7-pdo \
                            php7-pdo_dblib \
                            php7-pdo_mysql \
                            php7-pdo_odbc \
                            php7-pdo_pgsql \
                            php7-pdo_sqlite \
                            php7-pear \
                            php7-pecl-amqp \
                            php7-pecl-apcu \
                            php7-pecl-ast \
                            php7-pecl-couchbase \
                            php7-pecl-event \
                            php7-pecl-gmagick \
                            php7-pecl-igbinary \
                            php7-pecl-imagick \
                            php7-pecl-lzf \
                            php7-pecl-mailparse \
                            php7-pecl-mcrypt \
                            php7-pecl-memcache \
                            php7-pecl-memcached \
                            php7-pecl-msgpack \
                            php7-pecl-oauth \
                            php7-pecl-protobuf \
                            php7-pecl-psr \
                            php7-pecl-redis \
                            php7-pecl-ssh2 \
                            php7-pecl-timezonedb \
                            php7-pecl-uploadprogress \
                            php7-pecl-uuid \
                            php7-pecl-vips \
                            php7-pecl-xdebug \
                            php7-pecl-xhprof \
                            php7-pecl-yaml \
                            php7-pecl-zmq \
                            php7-pgsql \
                            php7-phalcon \
                            php7-phar \
                            php7-phpdbg \
                            php7-posix \
                            php7-pspell \
                            php7-recode \
                            php7-session \
                            php7-shmop \
                            php7-simplexml \
                            php7-snmp \
                            php7-soap \
                            php7-sockets \
                            php7-sodium \
                            php7-sqlite3 \
                            php7-tidy \
                            php7-tokenizer \
                            php7-wddx \
                            php7-xml \
                            php7-xmlreader \
                            php7-xmlrpc \
                            php7-xmlwriter \
                            php7-xsl \
                            php7-zip \
                            " && \
    \
    export PHP_7_2_RUN_DEPS=" \
                            php7 \
                            php7-bcmath \
                            php7-bz2 \
                            php7-calendar \
                            php7-common \
                            php7-ctype \
                            php7-curl \
                            php7-dba \
                            php7-dom \
                            php7-embed \
                            php7-enchant \
                            php7-exif \
                            php7-fileinfo \
                            php7-fpm \
                            php7-ftp \
                            php7-gd \
                            php7-gettext \
                            php7-gmp \
                            php7-iconv \
                            php7-imap \
                            php7-intl \
                            php7-json \
                            php7-ldap \
                            php7-litespeed \
                            php7-mbstring \
                            php7-mysqli \
                            php7-mysqlnd \
                            php7-odbc \
                            php7-opcache \
                            php7-openssl \
                            php7-pcntl \
                            php7-pdo \
                            php7-pdo_dblib \
                            php7-pdo_mysql \
                            php7-pdo_odbc \
                            php7-pdo_pgsql \
                            php7-pdo_sqlite \
                            php7-pear \
                            php7-pear-auth_sasl \
                            php7-pear-auth_sasl2 \
                            php7-pear-mail_mime \
                            php7-pear-mdb2_driver_mysql \
                            php7-pear-mdb2_driver_pgsql \
                            php7-pear-net_sieve \
                            php7-pear-net_smtp \
                            php7-pear-net_socket \
                            php7-pecl-amqp \
                            php7-pecl-apcu \
                            php7-pecl-ast \
                            php7-pecl-couchbase \
                            php7-pecl-event \
                            php7-pecl-gmagick \
                            php7-pecl-igbinary \
                            php7-pecl-imagick \
                            php7-pecl-lzf \
                            php7-pecl-mailparse \
                            php7-pecl-mcrypt \
                            php7-pecl-memcached \
                            php7-pecl-mongodb \
                            php7-pecl-oauth \
                            php7-pecl-redis \
                            php7-pecl-timezonedb \
                            php7-pecl-xdebug \
                            php7-pecl-yaml \
                            php7-pecl-zmq \
                            php7-pgsql \
                            php7-phalcon \
                            php7-phar \
                            php7-phpdbg \
                            php7-posix \
                            php7-pspell \
                            php7-recode \
                            php7-session \
                            php7-shmop \
                            php7-simplexml \
                            php7-snmp \
                            php7-soap \
                            php7-sockets \
                            php7-sodium \
                            php7-sqlite3 \
                            php7-tidy \
                            php7-tokenizer \
                            php7-wddx \
                            php7-xml \
                            php7-xmlreader \
                            php7-xmlrpc \
                            php7-xmlwriter \
                            php7-xsl \
                            php7-zip \
                            " && \
    \
    export PHP_7_1_RUN_DEPS=" \
                            php7 \
                            php7-amqp \
                            php7-apcu \
                            php7-bcmath \
                            php7-bz2 \
                            php7-calendar \
                            php7-common \
                            php7-ctype \
                            php7-curl \
                            php7-dba \
                            php7-dom \
                            php7-embed \
                            php7-enchant \
                            php7-exif \
                            php7-fileinfo \
                            php7-fpm \
                            php7-ftp \
                            php7-gd \
                            php7-gettext \
                            php7-gmp \
                            php7-iconv \
                            php7-imagick \
                            php7-imap \
                            php7-intl \
                            php7-json \
                            php7-ldap \
                            php7-litespeed \
                            php7-mailparse \
                            php7-mbstring \
                            php7-mcrypt \
                            php7-memcached \
                            php7-mysqli \
                            php7-mysqlnd \
                            php7-oauth \
                            php7-odbc \
                            php7-opcache \
                            php7-openssl \
                            php7-pcntl \
                            php7-pdo \
                            php7-pdo_dblib \
                            php7-pdo_mysql \
                            php7-pdo_odbc \
                            php7-pdo_pgsql \
                            php7-pdo_sqlite \
                            php7-pear \
                            php7-pear-auth_sasl \
                            php7-pear-auth_sasl2 \
                            php7-pear-mail_mime \
                            php7-pear-mdb2_driver_mysql \
                            php7-pear-mdb2_driver_pgsql \
                            php7-pear-net_smtp \
                            php7-pear-net_socket \
                            php7-pgsql \
                            php7-phar \
                            php7-phpdbg \
                            php7-posix \
                            php7-pspell \
                            php7-recode \
                            php7-redis \
                            php7-session \
                            php7-shmop \
                            php7-simplexml \
                            php7-snmp \
                            php7-soap \
                            php7-sockets \
                            php7-sqlite3 \
                            php7-ssh2 \
                            php7-tidy \
                            php7-tokenizer \
                            php7-wddx \
                            php7-xdebug \
                            php7-xml \
                            php7-xmlreader \
                            php7-xmlrpc \
                            php7-xmlwriter \
                            php7-xsl \
                            php7-zip \
                            php7-zmq \
                            " && \
    \
    export PHP_7_0_RUN_DEPS=" \
                            php7 \
                            php7-apcu \
                            php7-bcmath \
                            php7-bz2 \
                            php7-calendar \
                            php7-common \
                            php7-ctype \
                            php7-curl \
                            php7-dba \
                            php7-dom \
                            php7-embed \
                            php7-enchant \
                            php7-exif \
                            php7-fpm \
                            php7-ftp \
                            php7-gd \
                            php7-gettext \
                            php7-gmp \
                            php7-iconv \
                            php7-imap \
                            php7-intl \
                            php7-json \
                            php7-ldap \
                            php7-litespeed \
                            php7-mbstring \
                            php7-mcrypt \
                            php7-mysqli \
                            php7-mysqlnd \
                            php7-odbc \
                            php7-opcache \
                            php7-openssl \
                            php7-pcntl \
                            php7-pdo \
                            php7-pdo_dblib \
                            php7-pdo_mysql \
                            php7-pdo_odbc \
                            php7-pdo_pgsql \
                            php7-pdo_sqlite \
                            php7-pear \
                            php7-pgsql \
                            php7-phar \
                            php7-phpdbg \
                            php7-posix \
                            php7-pspell \
                            php7-session \
                            php7-shmop \
                            php7-snmp \
                            php7-soap \
                            php7-sockets \
                            php7-sqlite3 \
                            php7-tidy \
                            php7-wddx \
                            php7-xdebug \
                            php7-xml \
                            php7-xmlreader \
                            php7-xmlrpc \
                            php7-xsl \
                            php7-zip \
                            php7-zlib \
                            " && \
    \
    export PHP_5_6_RUN_DEPS=" \
                            php5 \
                            php5-apcu \
                            php5-bcmath \
                            php5-bz2 \
                            php5-calendar \
                            php5-cli \
                            php5-common \
                            php5-ctype \
                            php5-curl \
                            php5-dba \
                            php5-dbg \
                            php5-dom \
                            php5-embed \
                            php5-enchant \
                            php5-exif \
                            php5-fpm \
                            php5-ftp \
                            php5-gd \
                            php5-gettext \
                            php5-gmp \
                            php5-iconv \
                            php5-imap \
                            php5-intl \
                            php5-json \
                            php5-ldap \
                            php5-mcrypt \
                            php5-mssql \
                            php5-mysql \
                            php5-mysqli \
                            php5-odbc \
                            php5-opcache \
                            php5-openssl \
                            php5-pcntl \
                            php5-pdo \
                            php5-pdo_dblib \
                            php5-pdo_mysql \
                            php5-pdo_odbc \
                            php5-pdo_pgsql \
                            php5-pdo_sqlite \
                            php5-pear \
                            php5-pgsql \
                            php5-phar \
                            php5-phpdbg \
                            php5-posix \
                            php5-pspell \
                            php5-shmop \
                            php5-snmp \
                            php5-soap \
                            php5-sockets \
                            php5-sqlite3 \
                            php5-suhosin \
                            php5-wddx \
                            php5-xml \
                            php5-xmlreader \
                            php5-xmlrpc \
                            php5-xsl \
                            php5-zip \
                            " && \
    \
    set -x && \
    apk update && \
    apk upgrade && \
    apk add -t .php-build-deps \
                build-base \
                gpgme-dev \
                php${PHP_BASE:0:1}-dev \
                && \
    \
    apk add -t .php-run-deps \
                ca-certificates \
                git \
                gnupg \
                mariadb-client \
                openssl \
                postgresql-client \
                $(printenv PHP_$(echo ${PHP_BASE} | sed 's|\.|_|g')_RUN_DEPS) \
                && \
    \
    ### PHP Setup
    ## Temp Fix for graphicsmagick
    if [ -f "/etc/php${PHP_BASE:0:1}/*magick*.ini" ]; then mv /etc/php${PHP_BASE:0:1}/conf.d/*magick*.ini /tmp; fi; \
    sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php${PHP_BASE:0:1}/php.ini && \
    if [ -f "/usr/sbin/php-fpm${PHP_BASE:0:1}" ] ; then ln -sf /usr/sbin/php-fpm${PHP_BASE:0:1} /usr/sbin/php-fpm ; fi ; \
    if [ -f "/usr/bin/php${PHP_BASE:0:1}" ] ; then ln -sf /usr/bin/php${PHP_BASE:0:1} /usr/sbin/php ; fi ; \
    if [ -f "/usr/bin/pecl${PHP_BASE:0:1}" ] ; then echo "pecl" ; ln -sf /usr/bin/pecl${PHP_BASE:0:1} /usr/sbin/pecl; fi ; \
    rm -rf /etc/logrotate.d/php* && \
    \
    ### Install PHP Composer
    if [ "${PHP_BASE:0:1}" = "5" ] ; then echo "suhosin.executor.include.whitelist = phar" >> /etc/php${PHP_BASE:0:1}/php.ini ; fi;  \
    curl -sSLk https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    if [ -f "/etc/php${PHP_BASE:0:1}/*magick*.ini" ]; then mv /tmp/*magick.ini* /etc/php${PHP_BASE:0:1}/conf.d/ ; fi ; \
    \
    ### Build Extra Extensions
    pecl install gnupg && \
    echo "extension=gnupg.so" > /etc/php${PHP_BASE:0:1}/conf.d/20-gnupg.ini && \
    \
    mkdir -p /etc/php${PHP_BASE:0:1}/mods-available/ && \
    #### Disabling any but core extensions - When using this image as a base for other images, you'll want to turn turn them on before running composer with the inverse of phpdisomd (phpenmod) to keep things clean
    set +x && \
    for module in /etc/php${PHP_BASE:0:1}/conf.d/*.ini; do if [ ! -L "${module}" ] ; then if [ "$(echo $(basename $module) | grep -c '^[0-9][0-9].*')" = "0" ] ; then mv "${module}" "$(dirname ${module})/20_$(basename ${module})" ; module="$(dirname ${module})/20_$(basename ${module})"; fi ; if ! grep -w -i -q ";priority" "$module"; then echo ";priority=$(basename $module .ini | cut -d _ -f1)" >> $module ; mv "${module}" /etc/php${PHP_BASE:0:1}/mods-available/$(basename ${module} .ini | cut -c 4-).ini; fi; fi; done; \
    rm -rf /etc/php${PHP_BASE:0:1}/conf.d/* && \
    php_env_plugins_enabled="$(set | sort | grep PHP_ENABLE_ | grep -i TRUE | cut -d _ -f 3 | cut -d = -f 1 |  tr [A-Z] [a-z])" && \
    for module in $php_env_plugins_enabled ; do if [ -f "/etc/php${PHP_BASE:0:1}/mods-available/${module}.ini" ] ; then priority=$(cat /etc/php${PHP_BASE:0:1}/mods-available/${module}.ini | grep ";priority" | cut -d = -f2) ; ln -sf "/etc/php${PHP_BASE:0:1}/mods-available/${module}.ini" /etc/php${PHP_BASE:0:1}/conf.d/${priority}-${module}.ini ; fi ; done ; \
    if [ "${PHP_BASE:0:1}" != "8" ] ; then priority=$(cat /etc/php${PHP_BASE:0:1}/mods-available/json.ini | grep ";priority" | cut -d = -f2) ; ln -sf "/etc/php${PHP_BASE:0:1}/mods-available/json.ini" /etc/php${PHP_BASE:0:1}/conf.d/${priority}-json.ini ; fi ; \
    set -x && \
    ### Cleanup
    apk del .php-build-deps && \
    rm -rf /var/cache/apk/* /usr/src/* /tmp/*

### Networking Configuration
EXPOSE 9000

### Files Addition
ADD install /

