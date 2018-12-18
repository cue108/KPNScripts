#!/bin/bash
# file name: startManageMultiAlgo.sh

NAME=X17VergeYimp
# open persistance mode on all GPUs and setting all GPU power limiti to 230 Watt
/usr/local/bin/scripts/prepareGpus.sh 190
# setting power limit for individual GPUs
nvidia-smi -i 4 -pl 230
nvidia-smi -i 8 -pl 230
nvidia-smi -i 1 -pl 200
sleep 5
connection="false"
while [ $connection = "false" ];
do
 /usr/bin/wget -q --spider http://google.com
 if [ $? -eq 0 ]; then
  connection="true"
  /usr/local/bin/scripts/screen.sh $NAME /usr/local/bin/minerScripts/yimp/startX17.sh
  # let screen session creates its first logs
 else
  echo $(date) "We are offline" >> /logs/connectivity.log
  sleep 5
 fi
done

exit 0
