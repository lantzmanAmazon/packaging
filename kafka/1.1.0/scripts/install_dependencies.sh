#!/bin/bash

echo Installing kafka $KafkaDownloadURL...
export PATH=~/bin:$PATH
export ZOOKEEPER_ID=1
export file=`basename ${KafkaDownloadURL}`

su - root -c 'mkdir -p /app/kafka'
wget $KafkaDownloadURL -P /app

tar -zxvf /app/$file -C /app/kafka
su - root -c 'mkdir -p /tmp/zookeeper'
python /tmp/zookeeperIdGenerator.py
echo "initLimit=5" >> /app/kafka/$KafkaInstallDirectory/config/zookeeper.properties
echo "syncLimit=2" >> /app/kafka/$KafkaInstallDirectory/config/zookeeper.properties

sed -i 's/Defaults    requiretty/Defaults    !requiretty/g' /etc/sudoers