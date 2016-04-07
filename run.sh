#!/bin/bash
sudo /etc/init.d/mysql start

/usr/local/sbin/opensipsdbctl create



/usr/local/sbin/opensipsctl start
