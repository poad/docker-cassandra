# docker-cassandra

Apache Cassandra with OpenJDK and Python 3.8. 

## setting up

### create keyspace name

1. run docker container and ash on container

```$bash
docker-compose up -d
docker exec -it cassandra sh
```

2. create keyspace name

```$ash
python3 create_keyspace.py test
```
