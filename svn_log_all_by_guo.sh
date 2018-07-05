#!/bin/sh

COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[0;32m"
COLOR_WHITE="\033[0;37m"
COLOR_OFF="\033[0;39m"


svn log ../ | sed -n '/guolb/,/-----$/ p'


for dir in `find ../Solutions/ -type d`; do
	if [ -d $dir/.svn ]; then
		echo "$dir"
        svn log "$dir" | sed -n '/guolb8245/,/-----$/ p'
		if [ "$?" != 0 ]; then
			echo "${COLOR_RED}=========================================================${COLOR_OFF}"
			echo "${COLOR_RED}error : svn log guolb8245${COLOR_OFF}"
			echo "${COLOR_RED}=========================================================${COLOR_OFF}"
			exit 1
		fi
	fi
done

echo "${COLOR_GREEN}=========================================================${COLOR_OFF}"
echo "${COLOR_GREEN}success : all svn log for guolb8245${COLOR_OFF}"
echo "${COLOR_GREEN}=========================================================${COLOR_OFF}"

