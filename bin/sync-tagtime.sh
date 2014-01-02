#!/bin/bash

cd /home/adam/src/TagTime

rsync -L -e ssh adam.log amesha@home:/home/amesha/src/TagTime/
rsync -L -e ssh adam.log amesha@osiris:/home/amesha/src/TagTime/

