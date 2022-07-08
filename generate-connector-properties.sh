#!/bin/sh

directory_name="connector-properties"

printf "\n1.Enter the Database name: "
read db

printf "\n2.Enter the Collection name: "
read collections

printf "\n3.Enter the connection string of First MongoDB Instance (Example: mongodb+srv://username:password@xxx.xxx.mongodb.net): "
read connection_string1

printf "\n4.Enter the connection string of Second MongoDB Instance (Example: mongodb+srv://username:password@xxx.xxx.mongodb.net): "
read connection_string2

if [[ ! -e $directory_name ]]; then
    mkdir -p $directory_name
else 
    rm -r $directory_name/*.properties
fi

onprem_override_topics=""
cloud_override_topics=""
onprem_topics=""
cloud_topics=""
onprem_delete_override_topics=""
cloud_delete_override_topics=""
onprem_delete_topics=""
cloud_delete_topics=""
for collection in $(echo $collections | sed "s/,/ /g")
do
    onprem_topics="${onprem_topics}onprem.${db}.${collection},"
    cloud_topics="${onprem_topics}cloud.${db}.${collection},"
    onprem_override_topics="${onprem_delete_override_topics}\ntopic.override.onprem.${db}.${collection}.collection=${collection}"
    cloud_override_topics="${cloud_delete_override_topics}\ntopic.override.cloud.${db}.${collection}.collection=${collection}"
    onprem_delete_topics="${onprem_delete_topics}onprem-delete.${db}.${collection},"
    cloud_delete_topics="${onprem_delete_topics}cloud-delete.${db}.${collection},"
    onprem_delete_override_topics="${onprem_delete_override_topics}\ntopic.override.onprem-delete.${db}.${collection}.collection=${collection}"
    cloud_delete_override_topics="${cloud_delete_override_topics}\ntopic.override.cloud-delete.${db}.${collection}.collection=${collection}"
done

sed -e "s;%DATABASE%;$db;g" -e "s;%COLLECTION%;$collection;g" -e "s;%CONNECTION_STRING1%;$connection_string1;g" template/cloud-source.template > $directory_name/all-cloud-source.properties
sed -e "s;%DATABASE%;$db;g" -e "s;%COLLECTION%;$collection;g" -e "s;%CONNECTION_STRING1%;$connection_string1;g" template/cloud-source-delete.template > $directory_name/all-cloud-source-delete.properties
sed -e "s;%DATABASE%;$db;g" -e "s;%COLLECTION%;$collection;g" -e "s;%CONNECTION_STRING2%;$connection_string2;g" template/onprem-source.template > $directory_name/all-onprem-source.properties
sed -e "s;%DATABASE%;$db;g" -e "s;%COLLECTION%;$collection;g" -e "s;%CONNECTION_STRING2%;$connection_string2;g" template/onprem-source-delete.template > $directory_name/all-onprem-source-delete.properties

sed -e "s;%DATABASE%;$db;g" -e "s;%COLLECTION%;$collection;g" -e "s;%CONNECTION_STRING1%;$connection_string1;g" -e "s;%ONPREM_TOPICS%;${onprem_topics%?};g" -e "s;%ONPREM_OVERRIDE_TOPICS%;$onprem_override_topics;g" template/cloud-sink.template > $directory_name/cloud-sink.properties
sed -e "s;%DATABASE%;$db;g" -e "s;%COLLECTION%;$collection;g" -e "s;%CONNECTION_STRING1%;$connection_string1;g" -e "s;%ONPREM_TOPICS%;${onprem_delete_topics%?};g" -e "s;%ONPREM_OVERRIDE_TOPICS%;$onprem_delete_override_topics;g" template/cloud-sink-delete.template > $directory_name/cloud-sink-delete.properties
sed -e "s;%DATABASE%;$db;g" -e "s;%COLLECTION%;$collection;g" -e "s;%CONNECTION_STRING2%;$connection_string2;g" -e "s;%CLOUD_TOPICS%;${cloud_topics%?};g" -e "s;%CLOUD_OVERRIDE_TOPICS%;$cloud_override_topics;g" template/onprem-sink.template > $directory_name/onprem-sink.properties
sed -e "s;%DATABASE%;$db;g" -e "s;%COLLECTION%;$collection;g" -e "s;%CONNECTION_STRING2%;$connection_string2;g" -e "s;%CLOUD_TOPICS%;${cloud_delete_topics%?};g" -e "s;%CLOUD_OVERRIDE_TOPICS%;$cloud_delete_override_topics;g" template/onprem-sink-delete.template > $directory_name/onprem-sink-delete.properties

sed -e "s;%DATABASE%;$db;g" template/clear-topics.template > clear-topics.sh

connector_properties_file_paths=$(find $(pwd)/connector-properties -maxdepth 1 -type f -not -path '*/\.*' | tr '\n' ' ')
sed -e "s;%CONNECTOR_FILE_PATHS%;${connector_properties_file_paths};g" template/start-kafka.template > start-kafka.sh

printf "\nSuccessfully generated the Connector Property files. \n\n"