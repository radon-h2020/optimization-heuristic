#!/bin/bash

#docker run -it --name test -v /container_data/:/root/data dacapodocker 

docker run -it --name test -v /container_data/:/root/data dacapodocker ./run1.sh avrora
docker rm test

docker run -it --name test -v /container_data/:/root/data dacapodocker ./run1.sh batik
docker rm test

docker run -it --name test -v /container_data/:/root/data dacapodocker ./run1.sh h2
docker rm test
docker run -it --name test -v /container_data/:/root/data dacapodocker ./run1.sh jython
docker rm test
docker run -it --name test -v /container_data/:/root/data dacapodocker ./run1.sh lusearch
docker rm test
docker run -it --name test -v /container_data/:/root/data dacapodocker ./run1.sh sunflow
docker rm test
docker run -it --name test -v /container_data/:/root/data dacapodocker ./run1.sh tradebeans
docker rm test
docker run -it --name test -v /container_data/:/root/data dacapodocker ./run1.sh tradesoap
docker rm test
docker run -it --name test -v /container_data/:/root/data dacapodocker ./run1.sh xalan
docker rm test

