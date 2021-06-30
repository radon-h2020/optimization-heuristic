#!/bin/bash

FolderName="${HOSTNAME:0:1}${HOSTNAME:6:8}+0+0-noht1"
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik luindex  $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan xalan $FolderName
docker rm test test1 test2

cp -Rf "/container_data/${HOSTNAME:0:1}${HOSTNAME:6:8}1/*" $FolderName
for d in /container_data/$FolderName/*/; do cp ~/DockerTemp_ParallelDockersV2/sar_loadcpu.m "$d"; done

############################# Round 2 ##############################################
FolderName="${HOSTNAME:0:1}${HOSTNAME:6:8}+0+0-noht2"



~/DockerTemp_ParallelDockersV2/main2dockers.sh batik batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik luindex  $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan xalan $FolderName
docker rm test test1 test2


cp -Rf "/container_data/${HOSTNAME:0:1}${HOSTNAME:6:8}1/*" $FolderName
for d in /container_data/$FolderName/*/; do cp ~/DockerTemp_ParallelDockersV2/sar_loadcpu.m "$d"; done

############################# Round 3 ##############################################
FolderName="${HOSTNAME:0:1}${HOSTNAME:6:8}+0+0-noht3"


~/DockerTemp_ParallelDockersV2/main2dockers.sh batik batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik luindex  $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan xalan $FolderName
docker rm test test1 test2


cp -Rf "/container_data/${HOSTNAME:0:1}${HOSTNAME:6:8}1/*" $FolderName
for d in /container_data/$FolderName/*/; do cp ~/DockerTemp_ParallelDockersV2/sar_loadcpu.m "$d"; done

############################# Round 4 ##############################################
FolderName="${HOSTNAME:0:1}${HOSTNAME:6:8}+0+0-noht4"


~/DockerTemp_ParallelDockersV2/main2dockers.sh batik batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik luindex  $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh batik xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh jython xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh luindex xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh lusearch xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh sunflow xalan $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan batik $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan jython $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan luindex $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan lusearch $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan sunflow $FolderName
docker rm test test1 test2
~/DockerTemp_ParallelDockersV2/main2dockers.sh xalan xalan $FolderName
docker rm test test1 test2

cp -Rf "/container_data/${HOSTNAME:0:1}${HOSTNAME:6:8}1/*" $FolderName
for d in /container_data/$FolderName/*/; do cp ~/DockerTemp_ParallelDockersV2/sar_loadcpu.m "$d"; done
