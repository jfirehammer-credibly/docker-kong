FROM centos:7
MAINTAINER Marco Palladino, marco@mashape.com

ENV KONG_VERSION 0.7.0

RUN yum install -y epel-release
RUN yum install -y https://github.com/Mashape/kong/releases/download/$KONG_VERSION/kong-$KONG_VERSION.el7.noarch.rpm && \
    yum clean all

VOLUME ["/etc/kong/"]

COPY config.docker/kong.yml /etc/kong/kong.yml

ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD ["kong", "start"]

# CMD kong start

EXPOSE 8000 8443 8001 7946
