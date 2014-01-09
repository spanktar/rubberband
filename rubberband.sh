#!/bin/bash

echo
echo -e "\e[1mWelcome to RubberBand!\e[0m"
echo "A friendly script to diagnose your ElasticSearch cluster"

echo -n "Ready to go, are you? y/N "
read -n 1 ready
echo
if [ "$ready" != "y" ]
then
    echo
    echo -e "\e[10;35mABORT!\e[0m"
    echo
    exit 1
fi

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
