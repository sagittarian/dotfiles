#!/bin/bash

if [ $(pgrep -cf tagtimed.pl) == 0 ]; then
    # echo tagtime is not running;
    cd ~/src/TagTime
    DISPLAY=:0 ./tagtimed.pl &
fi

