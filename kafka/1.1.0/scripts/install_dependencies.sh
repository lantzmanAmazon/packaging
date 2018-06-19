#!/bin/bash
source `dirname "$0"`/common.sh

echo Installing kafka $KafkaFile with $ZK_CONFIG_TYPE/$ZK_NODE_TYPE.properties...

su - root -c "mkdir -p $DATA_DIR"
su - root -c "mkdir -p $LOG_DIR"

echo Extracting Kafka to $KAFKA_HOME ...
su - root -c 'mkdir -p /app/kafka'
su - root -c  "cp `dirname "$0"`/../$KafkaFile /app/$KafkaFile"
tar -zxvf /app/$KafkaFile -C /app/kafka

echo Applying Zookeeper config `dirname "$0"`/$ZK_CONFIG_TYPE/$ZK_NODE_TYPE.properties
su - root -c "cp `dirname "$0"`/$ZK_CONFIG_TYPE/$ZK_NODE_TYPE.properties $KAFKA_HOME/config/zookeeper.properties"

# The instance identity document contains eht0 attached IP, which is not what we want,
# we want the one assigned to eth1 (the code has a fallback to eth0 altough we don't expect it to be the case)
ETH0IP=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep privateIp | awk -F\" '{print $4}')
echo eth0 IP: $ETH0IP
ETH0MAC=$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ | head -n 1) #1st line
echo mac0: $ETH0MAC
ETH1MAC=$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ | head -n 2 | tail -1) #2nd line
echo mac1: $ETH1MAC
IP0=$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$ETH0MAC/local-ipv4s)
echo IP0: $IP0
IP1=$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$ETH1MAC/local-ipv4s)
echo IP1: $IP1

PRIVATE_IP=$IP1
if [[ (-z "$IP1")  || ( "$IP1" == "$ETH0IP" ) ]]; then
    PRIVATE_IP=$IP0
fi

echo Private IP: $PRIVATE_IP
if [ -z "$PRIVATE_IP" ]; then
    echo Could not find private IP
    exit 1
fi

# The main assumption is that the IP determins the ID, and we control the IPs even when chaning instances
SERVER_ID=$(cat $KAFKA_HOME/config/zookeeper.properties | grep $PRIVATE_IP | awk -F"=" '{print $1}' | awk -F"." '{print $2}')
echo Server ID: $SERVER_ID
if [ -z "$SERVER_ID" ]; then
    echo Could not find server Id
    exit 1
fi
echo Generating zookeeper myid $SERVER_ID file in $KAFKA_HOME/data/myid   ..
su - root -c "echo $SERVER_ID > $KAFKA_HOME/data/myid"

echo Replacing the current node IP with 0.0.0.0
CONFIG=$(cat $KAFKA_HOME/config/zookeeper.properties)
su - root -c "echo ${CONFIG/$PRIVATE_IP/0.0.0.0} | tr " " "\n" >> $KAFKA_HOME/config/zookeeper-local.properties"