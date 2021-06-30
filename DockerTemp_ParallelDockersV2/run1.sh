#!/bin/bash
./cleandacapo.sh 
dt=`date +%Y%m%d`;
testname="$dt$1";
sar 5 100 -o log.sar &
java -jar dacapo-9.12-MR1-bach.jar $1 -n 1600 >bench1.txt 2>bench1.err &

t0=`date +%s.%N`;
echo "$t0" > psaux.data; 
for i in $(seq 1 1 5) 
do 
ps aux >> psaux.data; sleep 5; 
done
echo "------- End for loop ------"
t1=`date +%s.%N`;
echo $t1
echo $t1 >> psaux.data; 
./killdacapo.sh
echo "testname ::::: "+ $testname
mkdir /root/data/$testname
mv log.sar /root/data/$testname/log.sar
mv psaux.data /root/data/$testname/psaux.data
mv *.txt /root/data/$testname/
mv *.err /root/data/$testname/

#rm scratch -rf
