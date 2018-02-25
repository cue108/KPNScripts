#!/bin/bash
# file name: startManageMultiAlgo.sh

NAME=multiAlgoMiningPoolHub
# open persistance mode on all GPUs and setting all GPU power limiti to 230 Watt
/usr/local/bin/scripts/prepareGpus.sh 230
# setting power limit for gpu 0 to 210 watt. That one gets hot the most
nvidia-smi -i 0 -pl 200
nvidia-smi -i 8 -pl 180
sleep 10
connection="false"
while [ $connection = "false" ];
do
 /usr/bin/wget -q --spider http://google.com
 if [ $? -eq 0 ]; then
  connection="true"
  /usr/local/bin/scripts/screen.sh $NAME /usr/local/bin/minerScripts/miningPoolHub/startMultiAlgo.sh
  # let screen session creates its first logs
  sleep 20
  # watch screen session log to take special action on bminer!
  /usr/local/bin/scripts/startWatchBminer.sh -n $NAME
 else
  echo $(date) "We are offline" >> /logs/connectivity.log
  sleep 5
 fi
done

exit 0
