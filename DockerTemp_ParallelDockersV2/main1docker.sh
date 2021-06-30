#!/bin/bash
#./cleandacapo.sh 
#dt=`date +%Y%m%d`;
#testname="$dt$1-$2";
docker rm test #test1 test2 
#sar 5 100 -o log.sar &
#echo "111111111111"
#./main_rundocker.sh avrora &
#echo " 2222222222222222222"
# ./main_rundocker2.sh avrora & 
#echo "33333333333333333"
#docker run -it  --name test1 -v /container_data/:/root/data dacapodocker  main_rundocker.sh $1
#docker run -it  --name test2 -v /container_data/:/root/data dacapodocker  main_rundocker.sh $2

#java -jar dacapo-9.12-MR1-bach.jar $1 -n 1600 >bench1.txt 2>bench1.err &
#java -jar dacapo-9.12-MR1-bach.jar $2 -n 1600 >bench2.txt 2>bench2.err &




#!/bin/bash
################################~/DockerTemp_ParallelDockersV2/cleandacapo.sh 
dt=`date +%Y%m%d`;
testname="$dt$1";
sar 5 100 -o log.sar &

mkdir -p /container_data/$2
echo "111111111111"
~/DockerTemp_ParallelDockersV2/main_rundocker1.sh $testname $1 $2 &
echo " 2222222222222222222"
# ./main_rundocker2.sh $testname $2 &
echo "33333333333333333"

#java -jar dacapo-9.12-MR1-bach.jar $1 -n 1600 >bench1.txt 2>bench1.err &
#java -jar dacapo-9.12-MR1-bach.jar $2 -n 1600 >bench2.txt 2>bench2.err &

t0=`date +%s.%N`;
echo "$t0" > psaux.data; 
for i in $(seq 1 1 60) 
do 
ps aux >> psaux.data; sleep 5; 

if pgrep -x "docker" > /dev/null
then
    echo "Running"
else
    echo "Stopped"
    break
fi

done
t1=`date +%s.%N`;
echo $t1 >> psaux.data; 
~/DockerTemp_ParallelDockersV2/killdacapo.sh
docker stop test #test1 test2
docker rm test #test1 test2

echo "testname ::::: "+ $testname
#mkdir /root/data/$testname
mv log.sar /container_data/$2/$testname/log.sar
#mv psaux.data /container_data/p08/$testname/psaux.data
#mv *.txt /container_data/$testname
#mv *.err /container_data/$testname
