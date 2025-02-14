#!/bin/bash
# file name: startMultiInstance.sh

GPUS=(`nvidia-smi dmon -c 1 | grep -vE "^#" |  awk '{ print +$1 }'`)
echo There are ${#GPUS[@]} GPUs available.

# open persistance mode on all GPUs and setting all GPU power limit
/usr/local/bin/scripts/prepareGpus.sh 190

ProcessAndLogPrefix=x17VergeYimp

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
		while [  $COUNTER -lt 20 ]; do
			processOnGPU=(`nvidia-smi -q -i $id -d PIDS | grep  "Processes.*None"`)
			#echo R = ${#test[@]}
			if [ ${#processOnGPU[@]} -gt 0  ]
				then
				# special GPU id related actions go here
				if [ $id == 5 ] 
                                        then
                                        echo special action for GPU id $id
                                        nvidia-smi -i $id -pl 175
                                        #continue
                                fi
				if [ $id == 6 ] 
					then
					echo special action for GPU id $id
					nvidia-smi -i $id -pl 185
					#continue
				fi
				if [ $id == 7 ] 
					then
					echo special action for GPU id $id
					nvidia-smi -i $id -pl 185
					#continue
				fi				
				if [ $id == 8 ] 
                                        then
                                        echo special action for GPU id $id
                                        nvidia-smi -i $id -pl 185
                                        #continue
                                fi
				if [ $id == 9 ] 
                                        then
                                        echo special action for GPU id $id
                                        nvidia-smi -i $id -pl 185
                                        #continue
                                fi
				if [ $id == 10 ] 
                                        then
                                        echo special action for GPU id $id
                                        nvidia-smi -i $id -pl 170
                                        #continue
                                fi

				# default GPU id related actions go here
				/usr/local/bin/scripts/screen.sh $ProcessAndLogPrefix-GPU-$id \
				"/usr/local/bin/alexis78ccminer \
				-a x17 \
				-d $id \
				-i 23\
				-o stratum+tcp://yiimp.eu:3737 \
				-u DTVh1uDtAN5ci2k2DvEBsh8Rh48bBKo26v.GPU$id \
				-p c=XVG \
				--max-temp=79"				
				sleep 60
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
