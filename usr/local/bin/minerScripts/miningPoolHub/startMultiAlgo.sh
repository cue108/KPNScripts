#!/bin/bash
API="0.0.0.0:1880"
USERNAME=cue.rig1
PASS=yeshe
#while getopts c:a: option
#do
# case "${option}"
# in
# c) CASHCOIN=${OPTARG};;
# a) CASHADDRESS=${OPTARG};;
# esac
#done
while :
do
 echo ""
 echo "*****************************"
 echo "* switching to algo lyra2v2 *"
 echo "*****************************"
 echo "" 
 /usr/local/bin/alexis78ccminer -r 0 --max-temp=80 -a lyra2v2 -o stratum+tcp://hub.miningpoolhub.com:12018 -u $USERNAME -p $PASS -b $API
 echo ""
 echo "*******************************"
 echo "* switching to algo neoscrypt *"
 echo "*******************************"
 echo "" 
 /usr/local/bin/alexis78ccminer -r 0 --max-temp=80 -a neoscrypt -o stratum+tcp://hub.miningpoolhub.com:12012 -u $USERNAME -p d=0.03125 -b $API
 echo ""
 echo "*******************************"
 echo "* switching to algo equihash *"
 echo "*******************************"
 echo "" 
 /usr/local/bin/bminer -max-network-failures 1 -max-temperature 81 -uri stratum://$USERNAME:$PASS@europe.equihash-hub.miningpoolhub.com:12023 -api $API -watchdog=true
 echo ""
 echo "*********************************"
 echo "* switching to algo cryptonight *"
 echo "*********************************"
 echo "" 
 /usr/local/bin/nanashiccminer -r 0 --max-temp=80 -a cryptonight -o stratum+tcp://europe.cryptonight-hub.miningpoolhub.com:12024 -u $USERNAME -p $PASS -b $API
 echo ""
 echo "*********************************"
 echo "* switching to algo groestl *"
 echo "*********************************"
 echo "" 
 /usr/local/bin/nanashiccminer -r 0 --max-temp=80 -a groestl -o stratum+tcp://hub.miningpoolhub.com:12004 -u $USERNAME -p $PASS -b $API
 echo ""
 echo "****************************"
 echo "* switching to algo lyra2z *"
 echo "****************************"
 echo "" 
 /usr/local/bin/alexis78ccminer -r 0 --max-temp=80 -a lyra2 -o stratum+tcp://europe.lyra2z-hub.miningpoolhub.com:12025 -u $USERNAME -p $PASS -b $API
 echo ""
 echo "************************************"
 echo "* switching to algo Myriad-Groestl *"
 echo "************************************"
 echo "" 
 /usr/local/bin/alexis78ccminer -r 0 --max-temp=80 -a myr-gr -o stratum+tcp://hub.miningpoolhub.com:12005 -u $USERNAME -p $PASS -b $API
 echo ""
 echo "************************************"
 echo "* switching to algo skein *"
 echo "************************************"
 echo "" 
 /usr/local/bin/alexis78ccminer -r 0 --max-temp=80 -a skein -o stratum+tcp://hub.miningpoolhub.com:12016 -u $USERNAME -p d=12.6 -b $API
sleep 5
done
