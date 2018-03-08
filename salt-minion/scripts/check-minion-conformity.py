#!/usr/bin/env python2
import sys

if len(sys.argv) > 1:
    print "Usage: Verifie si le minion est en conforminte avec sa configuration sur le master."
    sys.exit(1)

import salt.client
import salt.config

__opts__ = salt.config.minion_config('/etc/salt/minion')
__opts__['test'] = 'True'
caller = salt.client.Caller(mopts=__opts__)
STATE_FALSE = []
STATE_NONE = []
for state, params in  caller.cmd('state.apply').iteritems():
    if params['result'] is False:
        STATE_FALSE.append(params['result'])
    if params['result'] is None:
        STATE_NONE.append(params['result'])

if len(STATE_FALSE) > 0:
    status_string = "CRITICAL: %s erreurs et %s configurations obsoletes" % (len(STATE_FALSE), len(STATE_NONE))
    print status_string
    sys.exit(2)
elif len(STATE_NONE) > 0:
    status_string = "WARNING: %s configurations obsoletes" % len(STATE_NONE)
    print status_string
    sys.exit(1)
else:
    print "OK: Pas de changements a appliquer"
    sys.exit(0)