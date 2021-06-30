#!/bin/bash

#docker run -it --name test -v /container_data/:/root/data dacapodocker 

docker run  --name test -v /container_data/:/root/data aalnafessah/dacapodocker ./run4.sh avrora avrora avrora avrora

docker rm test
