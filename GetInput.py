#!/usr/bin/python

import subprocess
import sys

result = subprocess.check_output("lsinput", stderr=subprocess.STDOUT, shell=True)

device = ""
foundDevice = False

for line in result.split("\n"):
    #print line
    if line.startswith("/dev/input"):
	device = line
        continue
    if line.startswith("   name") and "Advanced Silicon S.A CoolTouch" in line:
        print device
        foundDevice = True
        sys.exit()

if not foundDevice:
    print "No Touch Device Found"
    sys.exit(1)
