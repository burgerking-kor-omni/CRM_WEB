#!/bin/bash

PNAME=Jenkins
PID=`ps -ef|grep java|grep $PNAME|awk '{print $2}'`

if [ "x$PID" == "x" ]; then
  echo "$PNAME application not running."
  exit 0
fi

echo "Stop $PNAME application : $PID"
kill -9 $PID
