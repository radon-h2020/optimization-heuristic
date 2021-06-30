 #!/bin/bash

 docker run  --name test -v /container_data/:/root/data dacapodocker ./run1.sh avrora &
 docker run --name test2 -v /container_data/:/root/data dacapodocker ./run1.sh h2 

 docker rm test test2

