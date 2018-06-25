#!/bin/bash
source `dirname "$0"`/common.sh

echo Starting zookeeper daemon ...
echo "$(cat $KAFKA_HOME/config/zookeeper-local.properties)"
cd $KAFKA_HOME # Relative data file
# TODO: set KAFKA_HEAP_OPTS with the appropriate values, by default it's -Xmx512M -Xms512M
export KAFKA_HEAP_OPTS="-Xmx256M -Xms256M"
su - root -c "$KAFKA_HOME/bin/zookeeper-server-start.sh -daemon $KAFKA_HOME/config/zookeeper-local.properties"