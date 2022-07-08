#!/bin/sh

/Users/vittalpai/Work/KafkaDemo/kafka/bin/kafka-topics.sh --delete --bootstrap-server localhost:9092 --topic 'cloud-delete.partners.*'
/Users/vittalpai/Work/KafkaDemo/kafka/bin/kafka-topics.sh --delete --bootstrap-server localhost:9092 --topic 'onprem-delete.partners.*'
/Users/vittalpai/Work/KafkaDemo/kafka/bin/kafka-topics.sh --delete --bootstrap-server localhost:9092 --topic 'cloud.partners.*'
/Users/vittalpai/Work/KafkaDemo/kafka/bin/kafka-topics.sh --delete --bootstrap-server localhost:9092 --topic 'onprem.partners.*'

echo "Successfully deleted topics"
