#!/bin/bash

files={avrora,batik,h2,jython,lusearch,sunflow,tradebeans,tradesoap,xalan}                                       # Assign your list of files to an array
max=${#files[@]}                                  # Take the length of that array

for ((idxA=0; idxA<max; idxA++)); do              # iterate idxA from 0 to length
  for ((idxB=idxA; idxB<max; idxB++)); do         # iterate idxB from idxA to length
    echo "A: ${files[$idxA]}; B: ${files[$idxB]}" # Do whatever you're here for.
  done
done
