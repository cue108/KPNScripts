#!/bin/bash

# When this exits kill all back ground process also.
trap 'kill $(jobs -p)' EXIT
#trap 'killall tail' EXIT

# iterate through each given file names
for file in "$@"
do
	# show tails of each in background.
	tail -f $file | nl -s"^${file}>  " &
done

# wait .. until CTRL+C
wait

