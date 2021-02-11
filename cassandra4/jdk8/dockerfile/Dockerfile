ARG CASSANDRA_VERSION="4.0-beta4"
ARG CASSANDRA_ESUM="af253d45681eeadc23bb7ff76091756781d021c4adea17f1d5b5cbda7fa4a0d6615ca270433827ae739516a1b23e1c2bea06ce7c0264241df21772f911fbb7d4"

ARG CASSANDRA_HOME="/usr/local/cassandra"

FROM alpine:3 as Downloader

ARG CASSANDRA_VERSION
ARG CASSANDRA_ESUM

WORKDIR /tmp

RUN apk --update add --no-cache --virtual .build-deps \
    curl \
 && rm -rf /var/cache/apk/* \
 && curl -sSLo /tmp/apache-cassandra-${CASSANDRA_VERSION}-bin.tar.gz https://archive.apache.org/dist/cassandra/${CASSANDRA_VERSION}/apache-cassandra-${CASSANDRA_VERSION}-bin.tar.gz \
 && sha512sum /tmp/apache-cassandra-${CASSANDRA_VERSION}-bin.tar.gz \
 && echo "${CASSANDRA_ESUM}  /tmp/apache-cassandra-${CASSANDRA_VERSION}-bin.tar.gz" | sha512sum -c - \
 && tar xf /tmp/apache-cassandra-${CASSANDRA_VERSION}-bin.tar.gz \
 && rm -rf /tmp/apache-cassandra-${CASSANDRA_VERSION}/doc /tmp/apache-cassandra-${CASSANDRA_VERSION}/javadoc \
 && rm -rf /tmp/apache-cassandra-${CASSANDRA_VERSION}/NOTICE.txt /tmp/apache-cassandra-${CASSANDRA_VERSION}/NEWS.txt \
 && rm -rf /tmp/apache-cassandra-${CASSANDRA_VERSION}/CASSANDRA-14092.txt /tmp/apache-cassandra-${CASSANDRA_VERSION}/CHANGES.txt \
 && curl -sSLo /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py \
 && rm -rf /tmp/apache-cassandra-${CASSANDRA_VERSION}/conf/cassandra.yaml /tmp/apache-cassandra-${CASSANDRA_VERSION}/bin/*.bat

# COPY --chown=root:root assets/conf/cassandra.yaml /tmp/apache-cassandra-${CASSANDRA_VERSION}/conf/cassandra.yaml


FROM mcr.microsoft.com/java/jre-headless:8-zulu-alpine

LABEL maintainer="Kenji Saito<ken-yo@mbr.nifty.com>"

ENV LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    PATH=/root/.local/bin:${PATH}

USER root

COPY --from=Downloader /tmp/get-pip.py /tmp/get-pip.py
RUN apk --update add --no-cache python2 python3 bash \
 && rm -rf /var/cache/apk/* \
 && python3 /tmp/get-pip.py \
 && rm -rf /tmp/get-pip.py

ARG CASSANDRA_VERSION
ARG CASSANDRA_HOME

RUN addgroup -g 1000 -S cassandra \
 && adduser -u 1000 -S  cassandra -G cassandra

COPY --from=Downloader --chown=cassandra:cassandra /tmp/apache-cassandra-${CASSANDRA_VERSION} ${CASSANDRA_HOME}
COPY --chown=cassandra:cassandra assets/docker-entrypoint.sh /docker-entrypoint.sh

ENV PATH=${CASSANDRA_HOME}/bin:${CASSANDRA_HOME}/tools/bin:${PATH}

HEALTHCHECK CMD [ "java", "-version" ]

RUN mkdir -p /var/lib/cassandra/ \
 && mkdir -p ${CASSANDRA_HOME}/logs \
 && chmod 777 /var/lib/cassandra \
 && chmod 774 /docker-entrypoint.sh \
 && chown -R cassandra:cassandra /usr/local/cassandra/

EXPOSE 7000 7001 7199 9042 9160

USER cassandra

ENV CASSANDRA_HOME="${CASSANDRA_HOME}"
ENV CASSANDRA_CONF="${CASSANDRA_HOME}/conf"
ENV PATH=/home/cassandra/.local/bin:${PATH}

VOLUME /var/lib/cassandra

ENTRYPOINT [ "/docker-entrypoint.sh" ]
