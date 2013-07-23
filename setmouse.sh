#!/bin/bash

id=$(xinput list | grep -i mouse | perl -n -e'/id=(\d+)/ && print $1')

xinput set-button-map $id 3 2 1 


