FROM poad/docker-cassandra:3

LABEL maintainer="Kenji Saito<ken-yo@mbr.nifty.com>"

COPY --chown=root:root conf/cassandra.yaml /usr/local/cassandra/cassandra.yaml

EXPOSE 7000 7001 9042 9160

USER root

ENTRYPOINT [ "cassandra", "-f" ]

USER cassandra
