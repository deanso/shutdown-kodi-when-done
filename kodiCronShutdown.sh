#!/bin/bash

# Initiate a shutdown at a certain time: just schedule script via cron
# Do not interrupt viewing when a video is playing 
# After movie is finished you have 5 minutes to start something else, otherwise shutdown.

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# vars
log="/var/log/kodiShutdownCron.log"
now="`date +%d-%m-%Y-%H:%M:%S`"

f_shutdown()
{
shutdown now
}

f_now()
{
now="`date '+%d-%m-%Y %H:%M:%S'`"
}

f_get_playerid()
{
kodiGetPlayerId=$(curl --silent -H "Content-Type: application/json" --data '{"jsonrpc": "2.0", "method": "Player.GetActivePlayers", "id": 1}' http://127.0.0.1:8080/jsonrpc| jq -r '.result[].playerid')
}

f_mainloop()
{
echo "######### $now : kodiCronShutdown.sh ##########" >> $log
echo "## kodiCronShutdown.sh ## starting watch loop : $(date) ..." >> $log

while :
do
	f_get_playerid
       	sleep 2
        if [ "$kodiGetPlayerId" = "1" ]; then
                movieOn="true"
		f_now
        	echo "$now kodiCronShutdown.sh: in watch loop, movie on: $movieOn" >> $log
        else
                movieOn="false"
		f_now
        	echo "$now kodiCronShutdown.sh: in watch loop, movie on: $movieOn" >> $log
		echo "$now kodiCronShutdown.sh: wait 300 seconds and if there is still no movie started, shutdown." >> $log
		sleep 300
		f_get_playerid		
		        if [ "$kodiGetPlayerId" = "1" ]; then
	                	movieOn="true"
			else 
				f_now
				echo "$now f_shutdown" >> $log
				f_shutdown
			fi
        fi
done
}

#main:
f_mainloop
