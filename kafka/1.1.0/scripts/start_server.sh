#!/bin/bash
source common.sh

echo Starting zookeeper ...
su - root -c 'nohup $KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties > /dev/null 2>&1 &'

echo Starting Kafka ...
sed -i 's/KAFKA_JMX_OPTS=\"-D/KAFKA_JMX_OPTS=\"-Djava.net.preferIPv4Stack=true -D/g' $KAFKA_HOME/bin/kafka-run-class.sh


