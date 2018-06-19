#!/bin/bash
source `dirname "$0"`/common.sh

echo Installing kafka $KafkaFile with $ZK_CONFIG_TYPE/$ZK_NODE_TYPE.properties...

echo Extracting Kafka to $KAFKA_HOME ...
su - root -c 'mkdir -p /app/kafka'
su - root -c  "cp `dirname "$0"`/../$KafkaFile /app/$KafkaFile"
tar -zxvf /app/$KafkaFile -C /app/kafka

#echo Generating zookeeper id ..
#su - root -c 'mkdir -p /tmp/zookeeper'
#python `dirname "$0"`/zookeeperIdGenerator.py
#source /tmp/zookeeper/myid
#export ZOOKEEPER_ID=$ZOOKEEPERID

echo Applying Zookeeper config `dirname "$0"`/$ZK_CONFIG_TYPE/$ZK_NODE_TYPE.properties
su - root -c "cp `dirname "$0"`/$ZK_CONFIG_TYPE/$ZK_NODE_TYPE.properties $KAFKA_HOME/config/zookeeper.properties"
echo "$(cat $KAFKA_HOME/config/zookeeper.properties)"

#sed -i 's/Defaults    requiretty/Defaults    !requiretty/g' /etc/sudoers