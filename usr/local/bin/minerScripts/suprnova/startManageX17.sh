#!/bin/bash
# file name: startManageX17.sh

NAME=x17VergeSuprnova
# open persistance mode on all GPUs and setting all GPU power limiti to 230 Watt
/usr/local/bin/scripts/prepareGpus.sh 190
# setting power limit for gpu 0 to 210 watt. That one gets hot the most
nvidia-smi -i 6 -pl 180
nvidia-smi -i 7 -pl 180
sleep 10
connection="false"
while [ $connection = "false" ];
do
 /usr/bin/wget -q --spider http://google.com
 if [ $? -eq 0 ]; then
  connection="true"
  /usr/local/bin/scripts/screen.sh $NAME /usr/local/bin/minerScripts/suprnova/startX17.sh
  # let screen session creates its first logs
 else
  echo $(date) "We are offline" >> /logs/connectivity.log
  sleep 5
 fi
done

exit 0
