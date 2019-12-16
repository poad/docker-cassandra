from cqlengine import connection
from cqlengine.management import create_keyspace
import sys

keyspaceName = sys.argv[1]

connection.setup(['127.0.0.1'], "Test Cluster")
create_keyspace(keyspaceName, "SimpleStrategy", 1)
