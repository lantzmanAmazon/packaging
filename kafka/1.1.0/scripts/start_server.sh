#!/bin/bash
source `dirname "$0"`/common.sh

echo Starting zookeeper daemon ...
echo "$(cat $KAFKA_HOME/config/zookeeper.properties)"
su - root -c "nohup $KAFKA_HOME/bin/zookeeper-server-start.sh -daemon $KAFKA_HOME/config/zookeeper.properties"
