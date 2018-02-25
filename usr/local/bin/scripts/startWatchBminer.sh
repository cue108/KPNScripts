NAME=multiAlgoMinerScript
while getopts n: option
do
 case "${option}"
 in
 n) NAME=${OPTARG};;
 esac
done
tail -f /logs/$NAME.log | awk '/Accepted shares 0 Rejected shares 0/||/Get error: End of file/||/Get error: Authorization failed/ {system("echo $(date) !!!!Killing bminer!!!! >> /logs/watchAction.log && killall bminer")}' &
