#!/bin/bash
source `dirname "$0"`/common.sh

buildversion=221e15ec-9a28-4982-876e-b4fe7afb2cfd
simpleversion=1.0

monitoringRoot=/app/monitoring/$simpleversion
su - root -c "mkdir -p $monitoringRoot"
aws s3 cp --recursive s3://eyal-kafka-monitor/$buildversion/kafka-monitor $monitoringRoot
su - root -c "cp $monitoringRoot/build/lib/* $monitoringRoot" #Flatten
su - root -c "chmod 777 $monitoringRoot/*" #Script execution
