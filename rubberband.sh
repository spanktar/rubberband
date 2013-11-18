#!/bin/bash

echo
echo -e "\e[1mWelcome to RubberBand!\e[0m"
echo "A friendly script to diagnose your ElasticSearch cluster"

if [ ! $1 ]
then
    echo -e "\1;31mFAIL: No output file given!\e[0m"
    exit 1
fi
if [ -e $1 ]
then
    echo -en "\e[1;31m$1 exists. Overwrite? y/N \e[0m"
    read -n 1 confirm
    echo
    if [ "$confirm" != "y" ]
    then
    	echo
	echo -e "\e[10;35mABORT!\e[0m"
    	echo
    	exit 1
    fi
fi

outfile=$1

echo -n "Ready to go, are you? y/N "
read -n 1 ready
echo
if [ "$ready" == "y" ]
then
    echo
    echo "Mmmm, stretchy..."
    echo
else
    echo
    echo -e "\e[10;35mABORT!\e[0m"
    echo
    exit 1
fi

echo "Creating output file: $outfile"
touch $outfile

commands=('_mapping?pretty' '_settings?pretty' '_cluster/state?pretty'  '_cluster/settings?pretty' '_stats?all&pretty' '_nodes?all&pretty' '_nodes/stats?all&pretty')

echo "##################################" > $outfile
echo "ElasticSearch Cluster Information:" >> $outfile
echo "##################################" >> $outfile
echo >> $outfile

for command in "${commands[@]}"
    do
    echo "$command:" >> $outfile
    echo "############################################################" >> $outfile
    echo >> $outfile
    curl -s "localhost:9200/$command" >> $outfile
    echo >> $outfile
    echo >> $outfile
done

echo -e "\e[1;32mAll done!\e[0m"
echo
exit 0
