#!/bin/sh
IPSET_SET="$1"
IPSET_V4="$2"
IPSET_V6="$3"

if ! ipset list $IPSET_SET >"/dev/null"; then ipset create $IPSET_SET list:set; fi
if ! ipset list $IPSET_V4 >"/dev/null"; then ipset create $IPSET_V4 hash:ip family inet; fi
curl -s "http://httpdns.n.netease.com/httpdns/v2/d?domain=music.163.com,interface.music.163.com,interface3.music.163.com,apm.music.163.com,apm3.music.163.com,clientlog.music.163.com,clientlog3.music.163.com" |
    grep -Eo '[0-9]+?\.[0-9]+?\.[0-9]+?\.[0-9]+?' |
    sort | uniq | awk -va=${IPSET_V4} '{print "ipset add "a" "$1}' | sh >"/dev/null" 2>&1
ipset add $IPSET_SET $IPSET_V4
# IPv6 support
ip6tables -h >"/dev/null" 2>&1
if [ $? -eq 0 ]; then
    if ! ipset list $IPSET_V6 >"/dev/null"; then ipset create $IPSET_V6 hash:ip family inet6; fi
    khost -t AAAA music.163.com | grep "has IPv6" | awk -va=${IPSET_V6} -F ' ' '{print "ipset add "a" "$NF}' | sh >"/dev/null" 2>&1
    khost -t AAAA interface.music.163.com | grep "has IPv6" | awk -va=${IPSET_V6} -F ' ' '{print "ipset add "a" "$NF}' | sh >"/dev/null" 2>&1
    ipset add $IPSET_SET $IPSET_V6
fi
