#!/bin/bash

commands=('_cluster/health?pretty' '_mapping?pretty' '_settings?pretty' '_cluster/state?pretty'  '_cluster/settings?pretty' '_stats?all&pretty' '_nodes?all&pretty' '_nodes/stats?all&pretty')

echo "{"

for command in "${commands[@]}"
    do
    echo "\"$command\" : "
    curl -s "localhost:9200/$command"
    echo ","
done

echo "}"
echo

exit 0
