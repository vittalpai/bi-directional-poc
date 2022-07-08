#!/bin/sh

echo "Starting Kafka Server.."
/Users/vittalpai/Work/KafkaDemo/kafka/bin/kafka-server-start.sh -daemon /Users/vittalpai/Work/KafkaDemo/kafka/config/server.properties

echo "Starting Zookeeper.."
/Users/vittalpai/Work/KafkaDemo/kafka/bin/zookeeper-server-start.sh -daemon /Users/vittalpai/Work/KafkaDemo/kafka/config/zookeeper.properties

sleep 20s
