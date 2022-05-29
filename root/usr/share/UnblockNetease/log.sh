#!/bin/sh
grep -B 1 {\"Id\":.*\"Artist\":.*\"Source\":.*} /tmp/log/UnblockNetease/app.log | awk -F "\n" '{print $1"\n"}'