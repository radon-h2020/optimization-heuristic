#!/bin/bash
./cleandacapo.sh 
dt=`date +%Y%m%d`;
testname="$dt$1";
sar 5 100 -o log.sar &
java -jar dacapo-9.12-MR1-bach.jar $1 -n 1600 >bench1.txt 2>bench1.err &

t0=`date +%s.%N`;
echo "$t0" > psaux.data; 
for i in $(seq 1 1 60) 
do 
ps aux >> psaux.data; sleep 5; 
done
echo "------- End for loop ------"
t1=`date +%s.%N`;
echo $t1
echo $t1 >> psaux.data; 
./killdacapo.sh
pwd
echo "testname ::::: "+ $testname
	
mkdir -p Metrics/$testname
mv log.sar /homes/aa23916/ToRunDacapo/DockerTemp/Metrics/$testname/log.sar
mv psaux.data /homes/aa23916/ToRunDacapo/DockerTemp/Metrics/$testname/psaux.data
mv *.txt /homes/aa23916/ToRunDacapo/DockerTemp/Metrics/$testname/
mv *.err /homes/aa23916/ToRunDacapo/DockerTemp/Metrics/$testname/
#rm scratch -rf
