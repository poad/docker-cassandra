ARG CASSANDRA_VERSION="3.11.5"
ARG CASSANDRA_ESUM="d559d351309ab4b702975abffae0663ffe6378cf7402c4bcb2f9b2b2f42ac7d017d7aa05f89ee523cab72d89c79d9fbc5ef692dfbb3f56d3993acd1f34cf1285"
ARG JAVA_VERSION="11u5-zulu-alpine"

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
 && tar xf /tmp/apache-cassandra-${CASSANDRA_VERSION}-bin.tar.gz


FROM mcr.microsoft.com/java/jre-headless:${JAVA_VERSION}

ARG CASSANDRA_VERSION

COPY --from=Downloader /tmp/apache-cassandra-${CASSANDRA_VERSION} /usr/local/cassandra

ENV PATH=/usr/local/cassandra/bin:${PATH}

HEALTHCHECK CMD [ "java", "-version" ]

RUN groupadd -g 1000 cassandra \
 && useradd -g 1000 -l -m -s /bin/false -u 1000 cassandra

USER cassandra
