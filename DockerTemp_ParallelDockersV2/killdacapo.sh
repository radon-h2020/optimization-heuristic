#!/bin/bash
ps aux|grep dacapo | grep java | awk '{print $2}' | xargs kill 2>/dev/null 
ps aux|grep sar| grep sadc| awk '{print $2}'| xargs kill 2>/dev/null
#docker stop test test1 test2
#docker rm test test1 test2
echo "************-------- Dacapo is killed -------- ****************"
