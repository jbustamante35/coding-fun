#!/bin/bash

# http://serverfault.com/a/767361/33170

displays=`ps aux | grep Xvnc | grep -v 'grep\|sed' | sed -r 's|.*(Xvnc :[0-9]*).*|\1|' | cut -d' ' -f 2`
limit=30

date
echo "Checking for inactive sessions!"
while read -r d; do
        export DISPLAY=$d
        idle=`xprintidle`
        idleMins=$(($limit/1000/60))
        if [[ $idleMins -gt $limit ]]; then
                # http://superuser.com/questions/909400/killing-vnc-process-manually
                echo "WARN Killing display $d because it is logged in for longer than ${limit}min (${idleMins}m)"
                PID=$(pgrep -f "vnc $d")
                echo "Killing $d ($PID)"
                kill -HUP $PID
                # http://linuxtoolkit.blogspot.com/2013/03/xrdpmmprocessloginresponse-login-failed.html
                FNAME=$(echo $d | sed -e 's/:/X/g')
                FILENAME="/tmp/.X11-unix/$FNAME"
                echo "Removing session for $d ($FILENAME)"
                rm -f $FILENAME
        else
                echo "INFO Display $d is still ok (${idleMins}m)"
        fi  
done <<< "$displays"