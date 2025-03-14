#!/bin/bash

declare -i duration=1
declare hasUrl=""
declare endpoint
declare -i MaxLoop=3
declare -i LoopCntr=0

usage() {
    cat <<END
    polling.sh [-i] [-h] endpoint
    
    Report the health status of the endpoint
    -i: include Uri for the format
    -h: help
END
}

while getopts "ih" opt; do 
  case $opt in 
    i)
      hasUrl=true
      ;;
    h) 
      usage
      exit 0
      ;;
    \?)
     echo "Unknown option: -${OPTARG}" >&2
     exit 1
     ;;
  esac
done

shift $((OPTIND -1))

if [[ $1 ]]; then
  endpoint=$1
else
  echo "Please specify the endpoint."
  usage
  exit 1 
fi 


healthcheck() {
    declare url=$1
    result=$(curl -i $url 2>/dev/null | grep HTTP/2)
    echo $result
}
while [ $LoopCntr -lt  $MaxLoop ]
do

    #while [[ true ]]; do
    result=`healthcheck $endpoint` 
    declare status
    if [[ -z $result ]]; then 
        status="N/A"
    else
        status=${result:7:3}
    fi 
     
    timestamp=$(date "+%Y%m%d-%H%M%S")
    if [ $status -eq 200 ]; then
        echo "$LoopCntr | $timestamp | $status | $endpoint " 
        exit 0
    else
        echo "$LoopCntr | $timestamp | $status | $endpoint " 
    fi 
    ((LoopCntr++))
    sleep $duration
    done
exit 99
