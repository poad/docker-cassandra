# docker-cassandra

Apache Cassandra with OpenJDK and Python 3.8.x based AlpineLinux

## setting up

### create keyspace name

1. run docker container and ash on container

```$sh
docker-compose up -d cassandra2 cassandra3
docker-compose exec cassandra1 cqlsh
```

2. create keyspace name

```$cqlsh
CREATE KEYSPACE test WITH replication = {'class':'SimpleStrategy', 'replication_factor' : 1};
exit
```
