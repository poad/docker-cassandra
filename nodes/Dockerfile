FROM poad/docker-cassandra:3

LABEL maintainer="Kenji Saito<ken-yo@mbr.nifty.com>"

COPY --chown=root:root conf/cassandra.yaml ${CASSANDRA_HOME}/cassandra.yaml

EXPOSE 7000 7001 9042 9160

USER root

RUN mkdir -p ${CASSANDRA_HOME}/data/ \
 && mkdir -p ${CASSANDRA_HOME}/logs \
 && chown -R cassandra:cassandra ${CASSANDRA_HOME}/data/ \
 && chown -R cassandra:cassandra ${CASSANDRA_HOME}/logs/
 
 USER cassandra

ENTRYPOINT [ "cassandra", "-f" ]

