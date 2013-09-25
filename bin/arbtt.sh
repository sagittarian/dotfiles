#!/bin/bash
if pgrep arbtt-capture > /dev/null
then
    exit 0
else
    DISPLAY=$(who | tr -s ' ' | cut -d ' ' -f 1,2 | grep : | grep $USER | cut -d ' ' -f 2)
    export DISPLAY
    notify-send 'arbtt is not running'
    arbtt-capture &
fi
