#!/bin/bash
echo Stopping ...
source `dirname "$0"`/common.sh

$KAFKA_HOME/bin/zookeeper-server-stop.sh
