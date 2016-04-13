FROM java:openjdk-8-jre-alpine
MAINTAINER Justin Plock <justin@plock.net>

LABEL name="zookeeper" version="3.5.0"

RUN apk add --no-cache wget bash \
    && mkdir /opt \
    && wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.5.0-alpha/zookeeper-3.5.0-alpha.tar.z | tar -xzf - -C /opt \
    && mv /opt/zookeeper-3.5.0-alpha /opt/zookeeper \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
    && mkdir -p /tmp/zookeeper

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]
