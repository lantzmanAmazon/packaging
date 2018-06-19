#!/bin/bash
source `dirname "$0"`/common.sh

echo Starting zookeeper daemon ...
echo "$(cat $KAFKA_HOME/config/zookeeper-local.properties)"
cd $KAFKA_HOME # Relative data file
su - root -c "$KAFKA_HOME/bin/zookeeper-server-start.sh -daemon $KAFKA_HOME/config/zookeeper-local.properties"
