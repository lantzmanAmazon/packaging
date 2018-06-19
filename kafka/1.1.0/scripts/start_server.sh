#!/bin/bash
source `dirname "$0"`/common.sh

PRIVATE_IP=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep privateIp | awk -F\" '{print $4}')
echo Private IP: $PRIVATE_IP
# The main assumption is that the IP determins the ID, and we control the IPs even when chaning instances
SERVER_ID=$(cat $KAFKA_HOME/config/zookeeper.properties | grep $PRIVATE_IP | awk -F"=" '{print $1}' | awk -F"." '{print $2}')
echo Server ID: $SERVER_ID

echo Starting zookeeper daemon ...
echo "$(cat $KAFKA_HOME/config/zookeeper.properties)"
su - root -c "nohup $KAFKA_HOME/bin/zookeeper-server-start.sh -daemon $KAFKA_HOME/config/zookeeper.properties"
