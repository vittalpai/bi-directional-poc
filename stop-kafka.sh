#!/bin/sh

echo "Stopping Kafka Connect...."
ps -ef | grep ConnectStandalone | grep -v grep | awk '{print $2}' | xargs kill

sleep 20

echo "Stopping Kafka...."
/Users/vittalpai/Work/KafkaDemo/kafka/bin/kafka-server-stop.sh /Users/vittalpai/Work/KafkaDemo/kafka/config/server.properties

echo "Stopping Zookeeper...."
/Users/vittalpai/Work/KafkaDemo/kafka/bin/zookeeper-server-stop.sh /Users/vittalpai/Work/KafkaDemo/kafka/config/zookeeper.properties

echo "Successfully stopped all the process."
