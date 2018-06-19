#!/bin/bash
echo Stopping ...
source `dirname "$0"`/common.sh

# TODO: replace with if
# Ignore failures in cases failed to start the instance 
$KAFKA_HOME/bin/zookeeper-server-stop.sh || true
