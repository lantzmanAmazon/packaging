#!/bin/bash
echo Stopping ...
source common.sh

$KAFKA_HOME/bin/kafka-server-stop.sh
