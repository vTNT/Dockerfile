FROM registry.dkhs.com/ubuntu

# Install Java 7

RUN apt-get update && apt-get clean
RUN apt-get install -q -y openjdk-7-jre-headless && \
    apt-get install --no-install-recommends -y software-properties-common
RUN mkdir -p /opt/sonatype-nexus /opt/sonatype-work-template /opt/sonatype-work
COPY file/nexus-latest-bundle.tar.gz /tmp/nexus-latest-bundle.tar.gz
RUN tar xzvf /tmp/nexus-latest-bundle.tar.gz -C /opt/sonatype-nexus --strip-components=1
RUN useradd --user-group --system --home-dir /opt/sonatype-nexus nexus
RUN chown -R nexus:nexus /opt/sonatype-work-template /opt/sonatype-work /opt/sonatype-nexus
ENV NEXUS_WEBAPP_CONTEXT_PATH /nexus
ADD start_as_nexus.sh /opt/start_as_nexus.sh
ADD start_nexus.sh /opt/start_nexus.sh
RUN ln -s /opt/start_nexus.sh /opt/start.sh

CMD ["/opt/start_as_nexus.sh"]
VOLUME /opt/sonatype-work
EXPOSE 8081
