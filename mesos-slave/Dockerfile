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

# Install.
RUN \
  locale-gen "en_US.UTF-8" && \
  locale-gen "zh_CN.UTF-8" && \
  apt-get update && \
  apt-get install -y time python-pip mysql-client libmysqlclient-dev python2.7-dev python-setuptools openssh-server libssl-dev && \
  apt-get install -y curl git vim lrzsz software-properties-common openssl libssl1.0.0 apt-transport-https && \
  apt-get upgrade -y

RUN \
  apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
  echo "deb http://repos.mesosphere.io/ubuntu trusty main" | tee /etc/apt/sources.list.d/mesosphere.list && \
  apt-get update && \
  apt-get install -y mesos && \
  rm -rf /var/lib/apt/lists/* 

# Install SSH
RUN mkdir /var/run/sshd
RUN echo 'root:123456' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

ADD ./requirements.txt /opt/requirements.txt
RUN pip install -r /opt/requirements.txt

# Install supervisor
ADD ./supervisord.conf /etc/supervisord.conf

# Expose ports.
EXPOSE 5051

# Define default command.
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod +x /sbin/entrypoint.sh
ENTRYPOINT ["/sbin/entrypoint.sh"]
