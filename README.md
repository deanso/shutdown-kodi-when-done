# shutdown-kodi-when-done


Bash script to shutdown kodi through cron when no movie is being played. 

Just schedule this script in cron to be run every day at say 01:00 hours.
It will shutdown the kodi install when no movie is on, else it will wait till movie is finished.
When movie is finished you have 5 minutes to start watching something else or it will shutdown.

original idea from here: https://andrewwippler.com/2015/07/06/kodi-shutdown-script/

### Prerequisites
install jq.
Script is only tested on Fedora 29 with Kodi 18

### Installing

install jq:
```
dnf install jq
```

copy the script and setup crontab to run every night at 01:00 hour:

```
0 1 * * * /script-location/kodiCronShutdown.sh
```






