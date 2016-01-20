#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#
# Pull base image.
FROM registry.dkhs.com/ubuntu

# Install.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y python-pip mysql-client libmysqlclient-dev python2.7-dev python-setuptools openssh-server && \
  apt-get install -y libjpeg-dev libfreetype6-dev zlib1g-dev libpng12-dev && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  chown -R www-data:www-data /var/lib/nginx

# Add files.
ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/nginx-site.conf /etc/nginx/sites-available/default

VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Install RabbitMQ.
RUN \
  wget -qO - https://www.rabbitmq.com/rabbitmq-signing-key-public.asc | apt-key add - && \
  echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y rabbitmq-server && \
  rm -rf /var/lib/apt/lists/* && \
  rabbitmq-plugins enable rabbitmq_management && \
  echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config && \
  chown -R rabbitmq:rabbitmq /var/lib/rabbitmq && \
  chown -R rabbitmq:rabbitmq /var/log/rabbitmq

ADD rabbitmq/rabbitmq-env.conf /etc/rabbitmq/rabbitmq-env.conf
# Install Celeryd
RUN mkdir -p /var/log/celery
RUN mkdir -p /var/run/celery
ADD celeryd/celeryd.init /etc/init.d/celeryd
ADD celeryd/celeryd.default /etc/default/celeryd

RUN /usr/bin/easy_install celery
RUN chmod +x /etc/init.d/celeryd

# Install SSH
RUN mkdir /var/run/sshd
RUN echo 'root:123456' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Install supervisor
RUN /usr/bin/easy_install supervisor
RUN /usr/bin/easy_install supervisor-stdout
ADD ./supervisord.conf /etc/supervisord.conf

# Expose ports.
EXPOSE 80

# Define default command.
COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh
ENTRYPOINT ["/bin/entrypoint.sh"]
