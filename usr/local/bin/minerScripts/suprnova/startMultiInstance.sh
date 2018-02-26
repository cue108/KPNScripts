#!/bin/bash
# file name: startMultiInstance.sh

GPUS=(`nvidia-smi dmon -c 1 | grep -vE "^#" |  awk '{ print +$1 }'`)
echo There are ${#GPUS[@]} GPUs available.

# open persistance mode on all GPUs and setting all GPU power limit
/usr/local/bin/scripts/prepareGpus.sh 230

ProcessAndLogPrefix=x17VergeSuprnova

# we check for internet connectivity first
connection="false"
while [ $connection = "false" ];
do
 /usr/bin/wget -q --spider http://google.com
 if [ $? -eq 0 ]; then
	connection="true"
	for id in "${GPUS[@]}"; do
		# we undergo MAX 10 attampts to start the mining process for the given GPU
		COUNTER=0
		while [  $COUNTER -lt 10 ]; do
			processOnGPU=(`nvidia-smi -q -i $id -d PIDS | grep  "Processes.*None"`)
			#echo R = ${#test[@]}
			if [ ${#processOnGPU[@]} -gt 0  ]
				then
				# special GPU id related actions go here
				if [ $id == 6 ] 
					then
					echo special action for GPU id $id
					nvidia-smi -i $id -pl 180
					#continue
				fi
				if [ $id == 7 ] 
					then
					echo special action for GPU id $id
					nvidia-smi -i $id -pl 180
					#continue
				fi				
				# default GPU id related actions go here
				/usr/local/bin/scripts/screen.sh $ProcessAndLogPrefix-GPU-$id \
				"/usr/local/bin/alexis78ccminer \
				-a x17 \
				-d $id \
				-o stratum+tcp://xvg-x17.suprnova.cc:7477 \
				-u hans23.GPU$id \
				-p yeshe \
				--api-bind=0.0.0.0:400$id \
				--api-remote \
				--max-temp=79"				
				sleep 2
			else
				break
			fi
		 	let COUNTER=COUNTER+1 
		 	echo Attempt $COUNTER of 10 to start mining on GPU $id
		done
	done
else
  echo $(date) "We are offline" >> /logs/connectivity.log
  sleep 5
 fi
done

exit 0
