#!/bin/bash

FolderName="${HOSTNAME:0:1}${HOSTNAME:6:8}1"

~/DockerTemp_ParallelDockersV2/main1docker.sh batik $FolderName
docker rm test #test1 test2
~/DockerTemp_ParallelDockersV2/main1docker.sh jython $FolderName
docker rm test #test1 test2
~/DockerTemp_ParallelDockersV2/main1docker.sh luindex $FolderName
docker rm test #test1 test2
~/DockerTemp_ParallelDockersV2/main1docker.sh lusearch $FolderName
docker rm test #test1 test2
~/DockerTemp_ParallelDockersV2/main1docker.sh sunflow $FolderName
docker rm test #test1 test2
~/DockerTemp_ParallelDockersV2/main1docker.sh xalan $FolderName
docker rm test #test1 test2

for d in /container_data/$FolderName/*/; do cp ~/DockerTemp_ParallelDockersV2/sar_loadcpu.m "$d"; done


FolderName="${HOSTNAME:0:1}${HOSTNAME:6:8}2"

~/DockerTemp_ParallelDockersV2/main1docker.sh batik $FolderName
docker rm test #test1 test2
~/DockerTemp_ParallelDockersV2/main1docker.sh jython $FolderName
docker rm test #test1 test2
~/DockerTemp_ParallelDockersV2/main1docker.sh luindex $FolderName
docker rm test #test1 test2
~/DockerTemp_ParallelDockersV2/main1docker.sh lusearch $FolderName
docker rm test #test1 test2
~/DockerTemp_ParallelDockersV2/main1docker.sh sunflow $FolderName
docker rm test #test1 test2
~/DockerTemp_ParallelDockersV2/main1docker.sh xalan $FolderName
docker rm test #test1 test2

for d in /container_data/$FolderName/*/; do cp ~/DockerTemp_ParallelDockersV2/sar_loadcpu.m "$d"; done
