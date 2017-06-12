#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#
# Pull base image.
FROM registry.cn-hangzhou.aliyuncs.com/acs-sample/ubuntu:14.04

ENV LANG en_US.utf8
ENV LANGUAGE en_US.utf8

RUN mv /etc/localtime /etc/localtime.old; ln -s /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime

ADD cron/root /var/spool/cron/crontabs/root

# Install.
RUN \
  locale-gen "en_US.UTF-8" && \
  locale-gen "zh_CN.UTF-8" && \
  apt-get update && \
  apt-get install -y time python-pip mysql-client libmysqlclient-dev python2.7-dev python-setuptools openssh-server libssl-dev && \
  apt-get install -y curl git vim lrzsz software-properties-common openssl libssl1.0.0 apt-transport-https && \
  apt-get install -y libjpeg-dev libfreetype6-dev zlib1g-dev libpng12-dev memcached && \
  apt-get upgrade -y

RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir -p /var/log/nginx/uwsgi && \
  chown -R www-data:www-data /var/lib/nginx && \
  chown -R www-data:www-data /var/log/nginx

# Add files.
ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/nginx-site.conf /etc/nginx/sites-enabled/default
ADD cron/logrotate_nginx.conf /etc/logrotate.d/nginx

VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/dkhs/dkhs_web", "/home/cron"]

# Install Celeryd
RUN mkdir -p /var/log/celery
RUN mkdir -p /var/run/celery
ADD celeryd/celeryd.init /etc/init.d/celeryd
ADD celeryd/celeryd.default /etc/default/celeryd

ADD pip.conf /root/.pip/pip.conf

RUN pip install celery
RUN chmod +x /etc/init.d/celeryd

ADD .npmrc /root/.npmrc

# Install npm
RUN \
  curl --silent https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
  echo "deb https://deb.nodesource.com/node_6.x trusty main" | tee /etc/apt/sources.list.d/nodesource.list && \
  echo "deb-src https://deb.nodesource.com/node_6.x trusty main" | tee -a /etc/apt/sources.list.d/nodesource.list && \
  apt-key adv --keyserver pgp.mit.edu --recv D101F7899D41F3C3 && \
  echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -y nodejs yarn && \
  rm -rf /var/lib/apt/lists/*

# Install SSH
RUN mkdir /var/run/sshd
RUN echo 'root:123456' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Install supervisor
RUN pip install supervisor
RUN pip install supervisor-stdout
ADD ./supervisord.conf /etc/supervisord.conf

# Expose ports.
EXPOSE 80
EXPOSE 443
EXPOSE 22

# Define default command.
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod +x /sbin/entrypoint.sh
ENTRYPOINT ["/sbin/entrypoint.sh"]
