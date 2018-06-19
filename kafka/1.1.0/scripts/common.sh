KafkaFile=kafka_2.12-1.1.0.tgz
KafkaInstallDirectory=`(basename $KafkaFile .tgz)`
ZKSetup=5nodesetup # TODO: make an argument
ZKSetupNode=quorum # TODO: make an argument

export ZK_CONFIG_TYPE=$ZKSetup
export ZK_NODE_TYPE=$ZKSetupNode
export KAFKA_HOME=/app/kafka/$KafkaInstallDirectory
export PATH=~/bin:$PATH:$KAFKA_HOME/bin