FROM registry.dkhs.com/ubuntu
MAINTAINER linyd "vbb625@gmail.com"

RUN apt-get update && apt-get clean
RUN apt-get install -q -y openjdk-7-jre-headless && \
    apt-get install --no-install-recommends -y software-properties-common && \
    apt-add-repository ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y ansible && \
    echo '[local]\nlocalhost\n' > /etc/ansible/hosts
ADD http://mirrors.jenkins-ci.org/war/1.624/jenkins.war /opt/jenkins.war
RUN chmod 644 /opt/jenkins.war
VOLUME /var/lib/jenkins
ENV JENKINS_HOME /var/lib/jenkins
ENV TZ Asia/Shanghai

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD [""]
EXPOSE 8080
