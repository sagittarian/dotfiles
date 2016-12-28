#!/bin/bash

pkill redshift
"$@"
redshift.sh &
