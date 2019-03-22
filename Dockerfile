FROM        alpine:3.9
MAINTAINER  Alex Scott <alex@cgi-central.net>

# Prepare environment
RUN         mkdir -p /opt
RUN         addgroup -g 1000 phing
RUN         adduser -h /opt/composer -s /bin/ash -g "Phing" -u 1000 -D -G phing phing

# Packages management
RUN         apk update && \
            apk upgrade && \
            # Install packages
            apk add --no-cache \
                    ca-certificates graphviz shadow \
                    git git-lfs patch bash tar openssh-client zip \
                    npm \
                    php7-pear \
                    php7-zip \
                    php7-cli \
                    php7-ctype \
                    php7-curl \
                    php7-dom \
                    php7-json \
                    php7-mbstring \
                    php7-openssl \
                    php7-pdo_sqlite \
                    php7-phar \
                    php7-simplexml \
                    php7-tokenizer \
                    php7-xml \
                    php7-xmlwriter && \
            # clean
            rm -rf /var/cache/apk/*

RUN         npm install -g sass
### xxx

RUN         ln -s /usr/bin/sass /usr/bin/scss

RUN         /usr/bin/wget https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer -O - -q | php -- --quiet

RUN         mkdir -p /opt/composer/
#COPY        composer.json /opt/composer/composer.json

RUN         pear install Archive_Tar

RUN         git lfs install

# Run environment variable, required files, etc.
ENV         PHING_UID  1000
ENV         PHING_GID  1000
ENV         PATH=$PATH:/opt/composer/vendor/bin

CMD         ["/usr/bin/php"]
