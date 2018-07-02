#!/bin/bash
# file name: startMultiInstance.sh

GPUS=(`nvidia-smi dmon -c 1 | grep -vE "^#" |  awk '{ print +$1 }'`)
echo There are ${#GPUS[@]} GPUs available.

# open persistance mode on all GPUs and setting all GPU power limit
/usr/local/bin/scripts/prepareGpus.sh 190

ProcessAndLogPrefix=x17VergeSuprnova

# we check for internet connectivity first
connection="false"
while [ $connection = "false" ];
do
 /usr/bin/wget -q --spider http://google.com
 if [ $? -eq 0 ]; then
	connection="true"
	for id in "${GPUS[@]}"; do
	 	# special GPU id related actions go here
                if [ $id == 1 ] 
                        then
                        echo special driver action for GPU id $id
                        #nvidia-smi -i $id -pl 150
                fi
                if [ $id == 4 ] 
                        then
                        echo special driver action for GPU id $id
                        #nvidia-smi -i $id -pl 150
                fi
		# we undergo MAX 20 attampts to start the mining process for the given GPU
		COUNTER=0
		while [  $COUNTER -lt 20 ]; do
			processOnGPU=(`nvidia-smi -q -i $id -d PIDS | grep  "Processes.*None"`)
                        processOnRAM=(`ps afx | grep -i screen | grep "\-d $id"`)
                        if [ ${#processOnGPU[@]} -gt 0 ] && [ ${#processOnRAM[@]} -eq 0 ]
				then
				intensity=22
                                # special GPU id related actions go here
                                if [ $id == 6 ] 
                                        then
                                        echo special action for GPU id $id
                                        #continue
                                fi
				# default GPU id related actions go here
				echo "starting miner process for GPU $id!"
				/usr/local/bin/scripts/screen.sh $ProcessAndLogPrefix-GPU-$id \
				"/usr/local/bin/alexis78ccminer \
				-a x17 \
				-d $id \
				-i $intensity \
				-o stratum+tcp://xvg-x17.suprnova.cc:7477 \
				-u hans23.GPU$id \
				-p yeshe \
				--max-temp=79"				
				sleep 7
			else
				break
			fi
		 	let COUNTER=COUNTER+1 
		 	echo Attempt $COUNTER of 20 to start mining on GPU $id
		done
	done
else
  echo $(date) "We are offline" >> /logs/connectivity.log
  sleep 5
 fi
done

exit 0
