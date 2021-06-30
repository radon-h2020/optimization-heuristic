#!/bin/bash


./main1docker.sh avrora
docker rm test test1 test2
./main1docker.sh batik
docker rm test test1 test2
./main1docker.sh h2
docker rm test test1 test2
./main1docker.sh jython
docker rm test test1 test2
./main1docker.sh lusearch
docker rm test test1 test2
./main1docker.sh sunflow
docker rm test test1 test2
./main1docker.sh tradebeans
docker rm test test1 test2
./main1docker.sh tradesoap
docker rm test test1 test2
./main1docker.sh xalan
docker rm test test1 test2

