#!/bin/bash
source `dirname "$0"`/common.sh

echo Installing kafka $KafkaFile with $ZK_CONFIG_TYPE/$ZK_NODE_TYPE.properties...

echo Extracting Kafka to $KAFKA_HOME ...
su - root -c 'mkdir -p /app/kafka'
su - root -c  "cp `dirname "$0"`/../$KafkaFile /app/$KafkaFile"
tar -zxvf /app/$KafkaFile -C /app/kafka

#TODO: data should be defined in a separate volume
echo Generating zookeeper myid $SERVER_ID file in $KAFKA_HOME/data/myid   ..
su - root -c "mkdir -p $KAFKA_HOME/data"
su - root -c "echo $SERVER_ID > $KAFKA_HOME/data/myid"

echo Applying Zookeeper config `dirname "$0"`/$ZK_CONFIG_TYPE/$ZK_NODE_TYPE.properties
su - root -c "cp `dirname "$0"`/$ZK_CONFIG_TYPE/$ZK_NODE_TYPE.properties $KAFKA_HOME/config/zookeeper.properties"
echo "$(cat $KAFKA_HOME/config/zookeeper.properties)"