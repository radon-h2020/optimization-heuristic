declare -a encode_ids=(xalan tradesoap tradebeans lusearch sunflow jython h2 avrora batik)  
echo "#!/bin/bash"
for (( i = 0; i < ${#encode_ids[@]}; ++i )); do
  for (( j = i + 1; j < ${#encode_ids[@]}; ++j )); do
  	for (( x = j+1; x < ${#encode_ids[@]}; ++x )); do
  		for (( z = x + 1; z < ${#encode_ids[@]}; ++z )); do
	  		echo "./main4dockers.sh" "${encode_ids[i]}" "${encode_ids[j]}" "${encode_ids[x]}" "${encode_ids[z]}"
			echo "docker rm test test1 test2 test3 test4"
 
		done
	done  
  done
done
