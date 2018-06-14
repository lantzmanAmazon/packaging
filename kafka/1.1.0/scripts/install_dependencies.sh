#!/bin/bash
source common.sh

echo Installing kafka $KafkaDownloadURL...
file=`basename ${KafkaDownloadURL}`
export KAFKA_HOME=/app/kafka/$KafkaInstallDirectory
export PATH=~/bin:$PATH:$KAFKA_HOME/bin

echo Downloading Kafka to $KAFKA_HOME ...
su - root -c 'mkdir -p /app/kafka'
cp ../$KafkaFile /app/$KafkaFile
tar -zxvf /app/$KafkaFile -C /app/kafka

echo Generating zookeeper id ..
su - root -c 'mkdir -p /tmp/zookeeper'
python zookeeperIdGenerator.py
source /tmp/zookeeper/myid
export ZOOKEEPER_ID=$ZOOKEEPERID

echo Applying Zookeeper config
echo "initLimit=5" >> $KAFKA_HOME/config/zookeeper.properties
echo "syncLimit=2" >> $KAFKA_HOME/config/zookeeper.properties

sed -i 's/Defaults    requiretty/Defaults    !requiretty/g' /etc/sudoers