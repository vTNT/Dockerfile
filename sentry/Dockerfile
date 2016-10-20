# Dockerfile for sentry (with mysql)
#
# VERSION 0.0.1

FROM registry.dkhs.com/ubuntu

# python related soft (including pip)
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y libxslt-dev python-dev python-pip libssl-dev libffi-dev libmysqlclient-dev redis-server expect

RUN pip install MySQL-python
RUN pip install "sentry==6.4.4"

# config for sentry
ADD conf/sentry.conf.py /etc/sentry.conf.py

# ports for sentry
EXPOSE 9000

# run supervisord in foreground
ADD entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["start"]

# some cleanup
RUN apt-get clean
RUN rm -rf /root/.cache/pip/wheels/*
