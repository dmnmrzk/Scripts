#!/usr/bin/python2

import urllib2
import base64
from xml.dom import minidom
import os

username = ""
password = "a"

request = urllib2.Request("http://localhost:8080/requests/status.xml")
b64string = base64.encodestring('%s:%s' % (username, password)).replace('\n', '')
request.add_header("Authorization", "Basic %s" % b64string)
vlc_xml = urllib2.urlopen(request).read()
DOMTree = minidom.parseString(vlc_xml)
position = float(DOMTree.getElementsByTagName("position")[0].childNodes[0].data)
title = DOMTree.getElementsByTagName("info")[0].childNodes[0].data

bar = "["
position_scaled = int(position * 21)
for i in range(position_scaled):
	bar += "="
for i in range(21- position_scaled):
	bar += " "
bar += "]"

msg = u"/me is watching " + title + "  " + bar + " " + str(int(position*100)) + "%"
print msg
