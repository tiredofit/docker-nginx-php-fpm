FROM tiredofit/alpine:3.6
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Default Runtime Environment Variables
ENV ZABBIX_HOSTNAME=nginx-php-fpm-ldap-app

### Build Nginx
ENV NGINX_VERSION 1.13.4

RUN GPG_KEYS=B0F4253373F8F6F510D42178520A9993A1C052F8 \
  && CONFIG="\
    --prefix=/etc/nginx \
    --sbin-path=/usr/sbin/nginx \
    --modules-path=/usr/lib/nginx/modules \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/run/nginx.lock \
    --http-client-body-temp-path=/var/cache/nginx/client_temp \
    --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
    --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
    --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
    --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
    --user=nginx \
    --group=nginx \
    --with-http_ssl_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_sub_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_random_index_module \
    --with-http_secure_link_module \
    --with-http_stub_status_module \
    --with-http_auth_request_module \
    --with-http_xslt_module=dynamic \
    --with-http_image_filter_module=dynamic \
    --with-http_geoip_module=dynamic \
    --with-http_perl_module=dynamic \
    --with-threads \
    --with-stream \
    --with-stream_ssl_module \
    --with-stream_ssl_preread_module \
    --with-stream_realip_module \
    --with-stream_geoip_module=dynamic \
    --with-http_slice_module \
    --with-mail \
    --with-mail_ssl_module \
    --with-compat \
    --with-file-aio \
    --with-http_v2_module \
    --add-module=/usr/src/nginx-auth-ldap \

  " \
  && addgroup -S www-data \
  && adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G www-data nginx \
  && apk add --no-cache --virtual .build-deps \
    gcc \
    libc-dev \
    make \
    libressl-dev \
    pcre-dev \
    zlib-dev \
    linux-headers \
    tar \
    gnupg \
    libxslt-dev \
    gd-dev \
    geoip-dev \
    perl-dev \
    tar \
    openldap-dev \

  && mkdir -p /usr/src/nginx-auth-ldap /www /www/logs/nginx \
  && curl https://codeload.github.com/kvspb/nginx-auth-ldap/tar.gz/master | tar xz --strip=1 -C /usr/src/nginx-auth-ldap \
  && curl -fSL http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz -o nginx.tar.gz \
  && curl -fSL http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz.asc  -o nginx.tar.gz.asc \
  && export GNUPGHOME="$(mktemp -d)" \
  && gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "$GPG_KEYS" \
  && gpg --batch --verify nginx.tar.gz.asc nginx.tar.gz \
  && rm -r "$GNUPGHOME" nginx.tar.gz.asc \
  && mkdir -p /usr/src \
  && tar -zxC /usr/src -f nginx.tar.gz \
  && rm nginx.tar.gz \
  && cd /usr/src/nginx-$NGINX_VERSION \
  && ./configure $CONFIG --with-debug \
  && make -j$(getconf _NPROCESSORS_ONLN) \
  && mv objs/nginx objs/nginx-debug \
  && mv objs/ngx_http_xslt_filter_module.so objs/ngx_http_xslt_filter_module-debug.so \
  && mv objs/ngx_http_image_filter_module.so objs/ngx_http_image_filter_module-debug.so \
  && mv objs/ngx_http_geoip_module.so objs/ngx_http_geoip_module-debug.so \
  && mv objs/ngx_http_perl_module.so objs/ngx_http_perl_module-debug.so \
  && mv objs/ngx_stream_geoip_module.so objs/ngx_stream_geoip_module-debug.so \
  && ./configure $CONFIG \
  && make -j$(getconf _NPROCESSORS_ONLN) \
  && make install \
  && rm -rf /etc/nginx/html/ \
  && mkdir /etc/nginx/conf.d/ \
  && mkdir -p /usr/share/nginx/html/ \
  && install -m644 html/index.html /usr/share/nginx/html/ \
  && install -m644 html/50x.html /usr/share/nginx/html/ \
  && install -m755 objs/nginx-debug /usr/sbin/nginx-debug \
  && install -m755 objs/ngx_http_xslt_filter_module-debug.so /usr/lib/nginx/modules/ngx_http_xslt_filter_module-debug.so \
  && install -m755 objs/ngx_http_image_filter_module-debug.so /usr/lib/nginx/modules/ngx_http_image_filter_module-debug.so \
  && install -m755 objs/ngx_http_geoip_module-debug.so /usr/lib/nginx/modules/ngx_http_geoip_module-debug.so \
  && install -m755 objs/ngx_http_perl_module-debug.so /usr/lib/nginx/modules/ngx_http_perl_module-debug.so \
  && install -m755 objs/ngx_stream_geoip_module-debug.so /usr/lib/nginx/modules/ngx_stream_geoip_module-debug.so \
  && ln -s ../../usr/lib/nginx/modules /etc/nginx/modules \
  && strip /usr/sbin/nginx* \
  && strip /usr/lib/nginx/modules/*.so \
  && rm -rf /usr/src/nginx-$NGINX_VERSION \
  \
  # Bring in gettext so we can get `envsubst`, then throw
  # the rest away. To do this, we need to install `gettext`
  # then move `envsubst` out of the way so `gettext` can
  # be deleted completely, then move `envsubst` back.
  && apk add --no-cache --virtual .gettext gettext \
  && mv /usr/bin/envsubst /tmp/ \
  \
  && runDeps="$( \
    scanelf --needed --nobanner /usr/sbin/nginx /usr/lib/nginx/modules/*.so /tmp/envsubst \
      | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
      | sort -u \
      | xargs -r apk info --installed \
      | sort -u \
  )" \
  && apk add --no-cache --virtual .nginx-rundeps $runDeps \
  && apk add --no-cache bash vim openldap nano less\
  && apk del .build-deps \
  && apk del .gettext \
  && mv /tmp/envsubst /usr/local/bin/ \
  \
  # forward request and error logs to docker log collector
  && rm -rf /usr/src/* /var/tmp/* /var/cache/apk/*


### Dependency Installation
  RUN apk update && \
      apk add \
          ca-certificates \
          mariadb-client \
          openssl \
          php7-apcu \
          php7-amqp \
          php7-bcmath \
          php7-bz2 \
          php7-calendar \
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
          php7-mailparse \
          php7-mbstring \
          php7-mcrypt \
          php7-memcached \
          php7-mysqli \
          php7-mysqlnd \
          php7-odbc \
          php7-opcache \
          php7-openssl \
          php7-pcntl \
          php7-pdo \
          php7-pdo_mysql \
          php7-pdo_pgsql \
          php7-pdo_sqlite \
          php7-pgsql \
          php7-phar\
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
          php7-tidy \
          php7-tokenizer \
          php7-wddx \
          php7-xdebug \
          php7-xml \
          php7-xmlreader \
          php7-xmlrpc \
          php7-xmlwriter \
          php7-xml \
          php7-zip \
          php7-zlib \
          php7-zmq \
          && \
      apk add -u musl && \
      rm -rf /var/cache/apk/* && \

### Nginx and PHP7 Setup
      sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php7/php.ini && \
      sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/www:\/bin\/bash/g" /etc/passwd && \
      sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/www:\/bin\/bash/g" /etc/passwd- && \
      ln -s /sbin/php-fpm7 /sbin/php-fpm && \

### Install PHP Composer
      curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \

### WWW  Installation
      mkdir -p /www/logs

### Files Addition
  ADD install /

### Networking Configuration
  EXPOSE 80

### Entrypoint Configuration
  ENTRYPOINT ["/init"]
