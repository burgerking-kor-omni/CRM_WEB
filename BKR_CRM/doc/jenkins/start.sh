#!/bin/bash

#JAVA_HOME=/usr/java/jre1.7.0_80

# Check process running ...
PNAME=Jenkins
PID=`ps -ef|grep java|grep $PNAME|awk '{print $2}'`

#echo $PID
if [ "x$PID" != "x" ]; then
  echo "$PNAME is already arunning... [$PID]"
  exit 0
fi

$JAVA_HOME/bin/java -D$PNAME -jar jenkins.war --httpPort=9090 &