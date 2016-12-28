#!/usr/bin/python3

import random
import os
import time

GOAL_INTERVAL = 180
# GOAL_INTERVAL changed from 60 to 180 on 2013-03-09 16:26:53
# GOAL_INTERVAL changed from 180 to 60 on 2013-04-16 20:52:07
# GOAL_INTERVAL changed from 60 to 180 on 2013-06-02 16:45:07
POLL_INTERVAL = 7

def happens(goal_interval, poll_interval):
	return random.random() < poll_interval / goal_interval

def open_browser(now):
	os.system("notify-send "
		"-t 10000 'time log - {}' 'write a time log report'".format(now))
	os.system("konqueror "
		"'https://raven.mesha.org/wiki/index.php"
		"?title=Special:Search&search=today'")

def open_file(now, fname='/home/adam/doc/timelog'):
	with open(fname, 'a') as fp:
		fp.write('\n{}: \n'.format(now))
	os.system('DISPLAY=:0 kwrite ' + fname)

def journal(goal_interval, poll_interval, action=open_file):
	if 1:#happens(goal_interval, poll_interval):
		now = time.strftime('%Y-%m-%d %H:%M:%S')
		action(now)

if __name__ == '__main__':
	journal(GOAL_INTERVAL, POLL_INTERVAL)

