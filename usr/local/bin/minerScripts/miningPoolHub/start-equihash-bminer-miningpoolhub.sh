#!/bin/sh
POOL="europe.equihash-hub.miningpoolhub.com"
PORT=17023 #switch coin per algo
#PORT=12023 #switch algo
PASS=yeshe
WORKER=rig1
USERNAME=cue
/usr/local/bin/bminer -uri stratum://$USERNAME.$WORKER:$PASS@$POOL:$PORT -api 0.0.0.0:1880
