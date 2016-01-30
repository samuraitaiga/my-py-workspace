#!/bin/bash

/etc/init.d/sshd status 2>&1 > /dev/null

if [ $? != 0 ]; then
  /etc/init.d/sshd start
fi

/bin/bash
