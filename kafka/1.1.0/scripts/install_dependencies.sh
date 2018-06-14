#!/bin/bash
source `dirname "$0"`/common.sh

echo Installing kafka $KafkaFile...
export KAFKA_HOME=/app/kafka/$KafkaInstallDirectory
export PATH=~/bin:$PATH:$KAFKA_HOME/bin

echo Extracting Kafka to $KAFKA_HOME ...
su - root -c 'mkdir -p /app/kafka'
cp `dirname "$0"`/../$KafkaFile /app/$KafkaFile
tar -zxvf /app/$KafkaFile -C /app/kafka

echo Generating zookeeper id ..
su - root -c 'mkdir -p /tmp/zookeeper'
python `dirname "$0"`/zookeeperIdGenerator.py
source /tmp/zookeeper/myid
export ZOOKEEPER_ID=$ZOOKEEPERID

echo Applying Zookeeper config
echo "initLimit=5" >> $KAFKA_HOME/config/zookeeper.properties
echo "syncLimit=2" >> $KAFKA_HOME/config/zookeeper.properties

sed -i 's/Defaults    requiretty/Defaults    !requiretty/g' /etc/sudoers