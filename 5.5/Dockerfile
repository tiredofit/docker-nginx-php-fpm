FROM tiredofit/alpine:3.4
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Default Runtime Environment Variables
 ENV PHP_INI_DIR=/etc/php5 \
     PHP_EXTRA_CONFIGURE_ARGS="--enable-fpm --with-fpm-user=nginx --with-fpm-group=www-data" \
     GPG_KEYS=F38252826ACD957EF380D39F2F7956BC5DA04B5D \
     PHP_VERSION=5.5.38 \
     PHP_URL="https://secure.php.net/get/php-5.5.38.tar.gz/from/this/mirror" \
     PHPIZE_DEPS="autoconf file g++ gcc libc-dev make pkgconf re2c" \
     ZABBIX_HOSTNAME=nginx-php-fpm-app
 
 COPY install/usr/local/bin/docker-* /usr/local/bin/

 RUN apk update && \
     apk add \
       ca-certificates \
       mysql-client \
       openssl \
       nginx \
       && \
     apk add -u musl && \
     rm -rf /var/cache/apk/* && \

### Nginx Setup
     sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/www:\/bin\/bash/g" /etc/passwd && \
     sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/www:\/bin\/bash/g" /etc/passwd- && \

     apk update && \
         apk add --no-cache --virtual .persistent-deps \
         openldap-dev \
         bzip2 \
         bzip2-dev \
         gettext-dev \
         gettext \
         libintl \
         libxslt \
         libxslt-dev \
         libxml2 \
         libxml2-dev \
         libmcrypt-dev \
         curl \
         tar \
         xz && \

     mkdir -p /etc/php5/conf.d && \
     set -xe && \
    
      apk add --no-cache --virtual .fetch-deps \
      gnupg \
      openssl \
      && \

      mkdir -p /usr/src && \
      cd /usr/src && \
     
      wget -O php.tar.gz "$PHP_URL" && \
     
      apk del .fetch-deps && \

      set -xe \
    && apk add --no-cache --virtual .build-deps \
      $PHPIZE_DEPS \
      curl-dev \
      db-dev \
      libedit-dev \
      libxml2-dev \
      openssl-dev \
      sqlite-dev \
    \
    && docker-php-source extract \
    && cd /usr/src/php \

    &&  ./configure \
      --with-config-file-path=/etc/php5 \
      --with-config-file-scan-dir=/etc/php5/conf.d \
      \
      --disable-cgi \
      \
      --enable-ftp \
      --enable-bcmath \
      --enable-exif \
      --enable-mbstring \
      --enable-pcntl \
      --enable-soap \
      --enable-sockets \
      --enable-sqlite \
      --enable-wddx \
      --enable-zip \
      --enable-calendar \
      --enable-mysqlnd \
      --with-curl \
      --with-libedit \
      --with-openssl \
      --with-zlib \
      --with-mhash \
      --with-mcrypt \
      --with-mysql=mysqlnd \
      --with-mysqli=mysqlnd \
      --with-xmlrpc \
      --with-xsl \
  #    --with-tidy \
      --with-gettext \
      $PHP_EXTRA_CONFIGURE_ARGS \
    && make -j "$(getconf _NPROCESSORS_ONLN)" \
    && make install \
    && { find /usr/local/bin /usr/local/sbin -type f -perm +0111 -exec strip --strip-all '{}' + || true; } \
    && make clean \
    && docker-php-source delete \
    \
    && runDeps="$( \
      scanelf --needed --nobanner --recursive /usr/local \
        | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
        | sort -u \
        | xargs -r apk info --installed \
        | sort -u \
    )" \
    && apk add --no-cache --virtual .php-rundeps $runDeps \
    \
    && apk del .build-deps && \

      rm -rf /usr/local/etc && \
      cd /usr/local && \
      ln -s /etc/php5 etc && \

  #RUN docker-php-ext-install mysqli
      apk upgrade --update && \
      apk add \
          coreutils \
          freetype-dev \
          libjpeg-turbo-dev \
          libltdl \
          libmcrypt-dev \
          libpng-dev \
          && \
      docker-php-ext-configure ldap --with-libdir=lib/ && \
      docker-php-ext-install ldap && \
      docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
      docker-php-ext-install -j$(nproc) gd && \
      docker-php-ext-install zlib && \
      rm -rf /usr/src/* /var/cache/apk/* && \


### WWW  Installation
      mkdir -p /www/logs

### Files Addition
  ADD install /

### Networking Configuration
  EXPOSE 80

### Entrypoint Configuration
  ENTRYPOINT ["/init"]

