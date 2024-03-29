# Settings for TagTime.
# This file must be in your home directory, called .pytagtimerc
# NB: restart the daemon (tagtimed.py) if you change this file.

import os
import subprocess
# import re
user = subprocess.getoutput('hostname')

# path is path to tagtime directory
path = "{{ src_dir }}/pytagtime"
# path to logfile
logf = os.path.join("{{ media_src_dir }}", "{{ org_repo }}", user + '.log')

# If you're using windows, you'll need cygwin and to set this flag to True:
# cygwin = False        # CHANGEME to True if you're using windows/cygwin.

ed = '{} -c'.format(subprocess.getoutput('which emacsclient'))
xt = subprocess.getoutput('which xterm')

# Get your personal Beeminder auth token (after signing in) from
#   https://www.beeminder.com/api/v1/auth_token.json
beemauth = "{{ beemauth }}"

# CHANGEME by adding entries for each beeminder graph you want to auto-update:
beeminder = {
    # "auron/concentrate": (lambda tags, ts:
    #                       re.search(r'\bwrk\b', tags) and
    #                       re.search('\bweb\b', tags) and
    #                       not '-old' in tags),
    # "auron/no-ticks": re.compile(r'\bhair\b|\bfing\b|\bface\b'),
  # "alice/work": "job",  # all "job" pings get added to bmndr.com/alice/work
  # "bob/play": ["fun","whee"], # pings w/ "fun" and/or "whee" sent to bob/play

  # ADVANCED USAGE: regular expressions
  # pings tagged like "eat1", "eat2", "eat3" get added to carol/food:
  # "carol/food": re.compile(r'beat\d+\b'),

  # ADVANCED USAGE: plug-in functions
  # pings tagged anything except "afk" get added to "dan/nafk":
  # "dan/nafk": lambda tags, ts: not re.search(r'\bafk\b', tags)
  # pings tagged "workout" get added to dave/tueworkouts, but only on tuesdays:
  # "dave/tueworkouts": lambda tags, ts: (re.search(r'\bworkout\b', tags) and
  #	   				                      ts.tm_wday == 2)
}

# Pings from more than this many seconds ago get autologged with tags "afk" and
# "RETRO". (Pings can be overdue either because the computer was off or tagtime
# was waiting for you to answer a previous ping. If the computer was off, the
# tag "off" is also added.)
retrothresh = 60

gap = 45*60   # Average number of seconds between pings (eg, 60*60 = 1 hour).

seed = 666    # For pings not in sync with others, change this (NB: > 0).

linelen = 79  # Try to keep log lines at most this long.

# catchup = 0  # Whether it beeps for old pings, ie, should it beep a bunch
               # of times in a row when the computer wakes from sleep.

# enforcenums = 0  # Whether it forces you to include a number in your
                   # ping response (include tag non or nonXX where XX is day
                   # of month to override). This is for task editor integration.

# System command that will play a sound for pings.
# Often "play" or "playsound" on Linux, or "afplay" on Mac osx.
# playsound = "afplay {path}/sound/blip-twang.wav".format(path)
# playsound = "echo -e '\a'"; # this is the default if playsound not defined.
playsound = ""  # makes tagtime stay quiet.
