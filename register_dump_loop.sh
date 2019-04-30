#!/bin/bash

mem=$1

old_status=`devmem $mem`
echo $old_status

# sys about 5sec loop
for i in {1..500} ; do
	status=`devmem $mem`
	if [ "$status" != "$old_status" ]; then
		echo $status
		old_status="$status"
	fi
	usleep 10000
done
