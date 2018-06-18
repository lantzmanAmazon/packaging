#!/bin/bash
source common.sh

echo Starting zookeeper ...
su - root -c 'nohup $KAFKA_HOME/bin/zookeeper-server-start.sh -daemon $KAFKA_HOME/config/zookeeper.properties'

#echo Starting Kafka ...
#TODO: missing properties
#sed -i 's/KAFKA_JMX_OPTS=\"-D/KAFKA_JMX_OPTS=\"-Djava.net.preferIPv4Stack=true -D/g' $KAFKA_HOME/bin/kafka-server-start.sh 


