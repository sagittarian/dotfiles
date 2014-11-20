#!/bin/bash

daemon=tagtimed.py

if [ $(pgrep -cf $daemon) == 0 ]; then
    # echo tagtime is not running;
    cd ~/src/pytagtime/
    DISPLAY=:0 ./$daemon &
fi

