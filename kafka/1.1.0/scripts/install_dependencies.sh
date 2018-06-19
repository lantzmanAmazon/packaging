#!/bin/bash
source `dirname "$0"`/common.sh

echo Installing kafka $KafkaFile with $ZK_CONFIG_TYPE/$ZK_NODE_TYPE.properties...

su - root -c "mkdir -p $DATA_DIR"
su - root -c "mkdir -p $LOG_DIR"

echo Extracting Kafka to $KAFKA_HOME ...
su - root -c 'mkdir -p /app/kafka'
su - root -c  "cp `dirname "$0"`/../$KafkaFile /app/$KafkaFile"
tar -zxvf /app/$KafkaFile -C /app/kafka

echo Applying Zookeeper config `dirname "$0"`/$ZK_CONFIG_TYPE/$ZK_NODE_TYPE.properties
su - root -c "cp `dirname "$0"`/$ZK_CONFIG_TYPE/$ZK_NODE_TYPE.properties $KAFKA_HOME/config/zookeeper.properties"
echo "$(cat $KAFKA_HOME/config/zookeeper.properties)"

PRIVATE_IP=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep privateIp | awk -F\" '{print $4}')
echo Private IP: $PRIVATE_IP
# The main assumption is that the IP determins the ID, and we control the IPs even when chaning instances
SERVER_ID=$(cat $KAFKA_HOME/config/zookeeper.properties | grep $PRIVATE_IP | awk -F"=" '{print $1}' | awk -F"." '{print $2}')
echo Server ID: $SERVER_ID
if [ -z "$SERVER_ID" ]; then
    echo Could not find server Id
    exit 1
fi
echo Generating zookeeper myid $SERVER_ID file in $KAFKA_HOME/data/myid   ..
su - root -c "echo $SERVER_ID > $KAFKA_HOME/data/myid"