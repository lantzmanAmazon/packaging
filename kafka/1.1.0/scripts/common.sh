KafkaFile=kafka_2.12-1.1.0.tgz
KafkaInstallDirectory=`(basename $KafkaFile .tgz)`
ZKSetup=5nodesetup # TODO: make an argument
ZKSetupNode=quorum # TODO: make an argument

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')
PRIVATE_IP=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep privateIp | awk -F\" '{print $4}')

# The main assumption is that the IP determins the ID, and we control the IPs even when chaning instances
SERVER_ID=$(cat config/zookeeper.properties | grep $PRIVATE_IP | awk -F"=" '{print $1}' | awk -F"." '{print $2}')

export ZK_CONFIG_TYPE=$ZKSetup
export ZK_NODE_TYPE=$ZKSetupNode
export KAFKA_HOME=/app/kafka/$KafkaInstallDirectory
export PATH=~/bin:$PATH:$KAFKA_HOME/bin