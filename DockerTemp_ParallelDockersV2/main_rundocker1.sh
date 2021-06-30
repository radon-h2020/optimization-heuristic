#!/bin/bash
mkdir /container_data/$3/$1
docker run -i --name test -v /container_data/$3/$1/:/root/data dacapodocker ./run1_Parallel1.sh $2
