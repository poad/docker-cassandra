#!/usr/bin/env sh

IP_ADDRESS=$(ip address | awk '$1 == "inet" && $NF != "lo" { gsub(/\/.+$/, "", $2); print $2; exit}')
echo "IP address: ${IP_ADDRESS}"

tmpFile=$(mktemp)
sed -e "s/localhost/${IP_ADDRESS}/g" ${CASSANDRA_HOME}/conf/cassandra.yaml > "${tmpFile}"

cat "${tmpFile}" > ${CASSANDRA_HOME}/conf/cassandra.yaml
rm -rf "${tmpFile}"

cassandra -f