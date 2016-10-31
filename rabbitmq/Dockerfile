FROM registry.cn-hangzhou.aliyuncs.com/acs-sample/ubuntu:14.04

ENV LANG en_US.utf8
ENV LANGUAGE en_US.utf8

RUN mv /etc/localtime /etc/localtime.old; ln -s /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime

# Add files.
ADD bin/rabbitmq-start /usr/local/bin/

# Install RabbitMQ.
RUN \
  locale-gen "en_US.UTF-8" && \
  locale-gen "zh_CN.UTF-8" && \
  apt-get update && \
  apt-get install -y wget openssl libssl1.0.0 && \
  wget -qO - https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add - && \
  echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list && \
  apt-get update && \
  apt-get upgrade -y && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y rabbitmq-server && \
  rm -rf /var/lib/apt/lists/* && \
  chmod +x /usr/local/bin/rabbitmq-start

RUN echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config

VOLUME ["/var/log/rabbitmq"]

# Define default command.
CMD ["rabbitmq-start"]

# Expose ports.
EXPOSE 5672
EXPOSE 25672
