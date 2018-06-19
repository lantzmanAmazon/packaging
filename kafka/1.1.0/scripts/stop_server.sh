#!/bin/bash
echo Stopping ...
source `dirname "$0"`/common.sh

# Stop, redirect failures to output to avoid not being
# able to deploy if the instance failed to start initially
$KAFKA_HOME/bin/zookeeper-server-stop.sh 2>&1 
