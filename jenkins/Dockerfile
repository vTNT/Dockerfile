FROM registry.cn-hangzhou.aliyuncs.com/acs-sample/ubuntu:14.04

ENV LANG en_US.utf8
ENV LANGUAGE en_US.utf8

RUN mv /etc/localtime /etc/localtime.old; ln -s /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime

RUN \
    locale-gen "en_US.UTF-8" && \
    locale-gen "zh_CN.UTF-8" && \
    apt-get update && apt-get clean
    
RUN \
    apt-get install -y software-properties-common wget && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y openjdk-8-jdk openjdk-8-jre lib32stdc++6 lib32z1 lib32z1-dev

ADD http://mirrors.jenkins-ci.org/war/latest/jenkins.war /opt/jenkins.war
RUN chmod 644 /opt/jenkins.war
VOLUME /var/lib/jenkins
ENV JENKINS_HOME /var/lib/jenkins
ENV TZ Asia/Shanghai

COPY docker-entrypoint.sh /
ADD requirements.yml /root/requirements.yml
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD [""]
EXPOSE 8080
