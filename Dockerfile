FROM java:openjdk-8-jre-alpine
MAINTAINER Justin Plock <justin@plock.net>

ENV VERSION 3.5.0-alpha
LABEL name="zookeeper" version="3.5.0"

RUN apk add --no-cache wget bash \
    && mkdir /opt \
    && wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-$VERSION/zookeeper-$VERSION.tar.z | tar -xzf - -C /opt \
    && mv /opt/zookeeper-$VERSION /opt/zookeeper \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
    && mkdir -p /tmp/zookeeper

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]
