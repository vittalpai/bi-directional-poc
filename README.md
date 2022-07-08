# Bi-Directional Synchronization for MongoDB

This repository contains a script to generate Kafka connector property files which can be used to enable Bi-directional synchronization in MongoDB Clusters.

## Prerequisites

- Kafka Cluster
- Two Instances of MongoDB Cluster


## Setup 

- Run the `generate-connector-properties.sh` script & fill the following details.
  - Database Name
  - Collection Name (If its more than one collection, Add it with comma seperated values (eg: coll1,coll2,coll3)
  - Connection String of First MongoDB Cluster
  - Connection String of Second MongoDB Cluster

- The script will generate the required connector property files inside the folder `connector-properties`

- Deploy the connector property files in your Kafka Cluster, this will enable the bi-directional synchronization.
