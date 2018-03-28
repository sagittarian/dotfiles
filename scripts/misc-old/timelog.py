#!/usr/bin/python3

import http.cookiejar, urllib.request
import json
import urllib.parse
import subprocess
import re
import time
import smtplib
from email.mime.text import MIMEText
from collections import defaultdict

USERNAME = 'adam'
import codecs
PASSWORD = codecs.getencoder('rot-13')('wqqhoyqth1')[0]
WIKIROOT = 'https://raven.mesha.org/wiki/'
APIURL = WIKIROOT + 'api.php'
EMAIL = 'adam@mesha.org'
SMTPHOST = 'smtp.gmail.com'
SMTPUSER = 'araizen@gmail.com'
SMTPPW = 'pnrofghpuuhqzeph'
SMTPPORT = 587

def login():
    '''Log in to the wiki with the global username and password
    return the opener with the proper cookie set'''
    cookiejar = http.cookiejar.CookieJar()
    opener = urllib.request.build_opener(
        urllib.request.HTTPCookieProcessor(cookiejar))
    postdatadict = {
        'action': 'login',
        'lgname': USERNAME,
        'lgpassword': PASSWORD,
        'format': 'json',
    }
    postdata = urllib.parse.urlencode(postdatadict).encode('ascii')

    result = None
    while result is None or result['login']['result'] == 'NeedToken':
        if result is not None and 'token' in result['login']:
            postdatadict['lgtoken'] = result['login']['token']
        postdata = urllib.parse.urlencode(postdatadict).encode('ascii')
        with opener.open(APIURL, postdata) as page:
            result = json.loads(page.read().decode('ascii'))

    return opener

def api(opener=None, **kw):
    if opener is None:
        opener = login()
    kw['format'] = 'json'
    url = APIURL + '?' + urllib.parse.urlencode(kw)
    with opener.open(url) as page:
        return json.loads(page.read().decode('ascii'))

def smquery(querystr, opener=None):
    return api(opener=opener, action='ask', query=querystr)

def pretty(printouts):
    d = {}
    for key in printouts:
        if not printouts[key]:
            d[key] = None
            continue
        data = printouts[key][0]
        if isinstance(data, dict):
            data = data['fulltext']
        d[key] = data
    return d

def timelog_items(mindate=None, maxdate=None, cat=None, subcat=None):
    '''Return all time logs matching the parameter criteria'''
    qstr = '[[object type::time log]]'
    if mindate is not None:
        qstr += '[[at::>{}]]'.format(mindate)
    if maxdate is not None:
        qstr += '[[at::<{}]]'.format(maxdate)
    if cat is not None:
        qstr += '[[cat::{}]]'.format(cat)
    if subcat is not None:
        qstr += '[[subcat::{}]]'.format(subcat)
    qstr += '|?at|?desc|?cat|?subcat|limit=10000'

    qresult = smquery(qstr)

    result = []
    for key in qresult['query']['results']:
        printouts = qresult['query']['results'][key]['printouts']
        result.append(pretty(printouts))

    return result

def timelog_ratios(mindate=None, maxdate=None):
    items = timelog_items(mindate=mindate, maxdate=maxdate)
    n = len(items)
    totals = defaultdict(int)
    for item in items:
        cat = item['Cat'].lower()
        totals[cat] += 1
        subcat = item['Subcat']
        if subcat is not None:
            subcat = subcat.lower()
            totals[(cat, subcat)] += 1
    for key in totals:
        totals[key] /= n
    totals['total'] = 1
    return totals

def arbtt_active_time(mindate=None, maxdate=None):
    '''Return the amount of time I was active on the computer
    according to arbtt-stats'''
    filter = []
    if mindate is not None:
        filter.append('format $date >= "{}"'.format(mindate))
    if maxdate is not None:
        filter.append('format $date <= "{}"'.format(maxdate))
    cmd = ['arbtt-stats', '-i', '-f', '{}'.format(' && '.join(filter))]
    result = subprocess.check_output(cmd).decode('utf-8')
    m = re.search(r'Total time selected\s*\|\s*(.*)', result)
    if m is None:
        return
    totaltime = m.group(1)
    s = 0
    for (num, unit) in re.findall(r'(\d+)([dhms])', totaltime):
        num = int(num)
        if 'd' == unit:
            s += num * 24 * 60 * 60
        elif 'h' == unit:
            s += num * 60 * 60
        elif 'm' == unit:
            s += num * 60
        elif 's' == unit:
            s += num
        else:
            raise ValueError("don't know unit " + unit)
    return s

def timelog_report(mindate=None, maxdate=None, only_ratios=False):
    ratios = timelog_ratios(mindate, maxdate)
    if not only_ratios:
        secs = arbtt_active_time(mindate, maxdate)
        hours = secs / (60 * 60)
        for key in ratios:
            ratios[key] *= hours

    if mindate is not None:
        ratios['mindate'] = mindate
    if maxdate is not None:
        ratios['maxdate'] = maxdate

    if mindate is not None:
        if maxdate is not None:
            heading = 'Time log from {} to {}'.format(mindate, maxdate)
        else:
            heading = 'Time log since {}'.format(mindate)
    elif maxdate is not None:
        heading = 'Time log up to {}'.format(maxdate)
    else:
        heading = 'Full time log'
    ratios['heading'] = heading

    return ratios

def prettify(report, round_hours=True):
    keys = sorted((k for k in report if k not in
                        ('total', 'mindate', 'maxdate', 'heading')),
        key=lambda k: (k[0], 0, k[1]) if isinstance(k, tuple) else (k, 1))
    r = []
    longest_key = max(len(key) if isinstance(key, str)
                               else len(key[0]) + len(key[1]) + 3
                      for key in report)
    if round_hours:
        def roundfunc(n):
            return round(n*2) / 2
    else:
        roundfunc = lambda n: round(n, 3)
    def mkrow(cat, num):
        return cat + ' ' * (longest_key + 5 - len(cat)) + str(roundfunc(num))
    for k in keys:
        cat = ('  ' + ' > '.join(k)) if isinstance(k, tuple) else '* ' + k
        r.append(mkrow(cat, report[k]))
    r.append(mkrow('total', report['total']))
    return report['heading'] + '\n\n' + '\n'.join(r) + '\n'

def weekago():
    t = time.time() - 7 * 24 * 60 * 60
    return time.strftime('%Y-%m-%d', time.localtime(t))

def email_msg(report, subject=None):
    reporttxt = prettify(report)
    msg = MIMEText('<pre>' + reporttxt + '</pre>', _subtype='html')

    msg['Subject'] = subject if subject is not None else report['heading']
    msg['From'] = EMAIL
    msg['To'] = EMAIL

    smtp = smtplib.SMTP(SMTPHOST, SMTPPORT)
    smtp.ehlo()
    smtp.starttls()
    smtp.ehlo()
    smtp.login(SMTPUSER, SMTPPW)
    smtp.send_message(msg)
    smtp.close()

def main():
    import sys
    if len(sys.argv) > 1 and sys.argv[1] == 'ratios':
        ratios = True
        del sys.argv[1]
    else:
        ratios = False
    if len(sys.argv) > 1 and sys.argv[1] == 'email':
        email = True
        args = sys.argv[2:]
    else:
        email = False
        args = sys.argv[1:]
    mindate = args[0] if len(args) > 0 else weekago()
    maxdate = args[1] if len(args) > 1 else None
    report = timelog_report(mindate=mindate, maxdate=maxdate,
                            only_ratios=ratios)
    if email:
        email_msg(report)
    else:
        print(prettify(report, round_hours=not ratios))

if __name__ == '__main__':
    main()
