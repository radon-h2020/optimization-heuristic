#!/bin/bash
mkdir -p /container_data/$3/$1
docker run -i --name test4 -v /container_data/$3/$1:/root/data dacapodocker ./run1_Parallel4.sh $2
