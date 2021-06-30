#!/bin/bash
mkdir -p /container_data/$3/$1
docker run -i --name test2 -v /container_data/$3/$1:/root/data dacapodocker ./run1_Parallel2.sh $2
