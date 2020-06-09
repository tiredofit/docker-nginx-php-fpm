FROM tiredofit/nginx:debian
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Default Runtime Environment Variables
ENV ZABBIX_HOSTNAME=nginx-php-fpm-app \
    ENABLE_SMTP=TRUE \
    NGINX_ENABLE_CREATE_SAMPLE_HTML=FALSE

### Dependency Installation
RUN set -x && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
               ca-certificates \
               mariadb-client \
               php7.3 \
               php7.3-bcmath \
               php7.3-bz2 \
               php7.3-cli \
               php7.3-common \
               php7.3-curl \
               php7.3-enchant \
               php7.3-fpm \
               php7.3-gd \
               php7.3-imap \
               php7.3-intl \
               php7.3-json \
               php7.3-ldap \
               php7.3-mbstring \
               php7.3-mysql \
               php7.3-odbc \
               php7.3-opcache \
               php7.3-pspell \
               php7.3-readline \
               php7.3-recode \
               php7.3-soap \
               php7.3-sqlite3 \
               php7.3-tidy \
               php7.3-xdebug \
               php7.3-xml \
               php7.3-xmlrpc \
               php7.3-xsl \
               php7.3-zip \
               postgresql-client \
               && \
    \
    ### PHP7 Setup
    sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.3/cli/php.ini && \
    ln -s /usr/sbin/php-fpm7.3 /usr/sbin/php-fpm && \
    rm -rf /etc/logrotate.d/php7.3-fpm && \
    \
    ### Install PHP Composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    \
    ### Cleanup
    mkdir -p /var/log/nginx && \
    rm -rf /var/lib/apt/lists/* /root/.gnupg /var/log/* 

### Networking Configuration
EXPOSE 9000

### Files Addition
ADD install /
