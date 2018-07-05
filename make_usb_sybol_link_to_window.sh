#!/bin/bash
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_WHITE='\033[0;37m'
COLOR_BLUE='\033[0;34m'
COLOR_OFF='\033[0;0m'
count=0
sharedirve=~/works
for DEV in /sys/block/sd*; do
    if readlink -f $DEV/device | grep -q usb; then
        DEV=`basename $DEV`
        echo "$DEV is a USB device, info"
        #udevadm info --query=all --name $DEV
        if [ -d /sys/block/${DEV}/${DEV}1 ]; then
            echo "Has partition " /sys/block/$DEV/$DEV[0-9]*
            for usb in /sys/block/$DEV/$DEV[0-9]*; do
                drivename=`basename $usb`
                usbdrive=/dev/$drivename
                mountpoint=$(df | awk ''/$drivename/' {print $6}')
                printf "mount point is  ${mountpoint} \n"
                # if there is space in mount point 
                # for example /dev/guo libao, the space in guo libao
                # below is for solving the space problem
                cd $mountpoint*
                mountdir=$(pwd)
                cd -
                printf "mount directory is $mountdir \n"
                printf "USB device is $usbdrive \n" 
                
                usb_name=$(basename "$mountdir")

                slink_name=thumbdrive_${drivename}_${usb_name}
                slink_path=$sharedirve/${slink_name}

                if [ -L "${slink_path}" ]; then
                    unlink "${slink_path}"
                fi
                
                printf "Create Symbol Link for Thumbdrive ... \n"
                
                ln -s "$mountdir" "${slink_path}"
				if [ $? -eq 0 ]; then
					let "count=count+1"
					printf "${COLOR_GREEN} Number of thumbdrive mounted : ${count} ${COLOR_OFF}\n"
                    printf "${COLOR_GREEN}Linked Point On windows is ${slink_path} ${COLOR_OFF}\n"
				else
					printf "${COLOR_RED}Creat Thumb Drive Link to Windows Errror !!!${COLOR_OFF}\n"
				fi
				
            done
        else
            echo "Has no partitions"
        fi
        echo
    fi
done
if [ $count -ne 0 ]; then
    echo "$count thumb drives mounted and created symbol link to windows "
else
    printf "${COLOR_RED}No thumb drive is mounted!!!${COLOR_OFF}\n"
    printf "${COLOR_RED}UnLink all the thumbdrive symbol links ${COLOR_OFF}\n"
    find $sharedirve -type l ! -exec test -e '{}' ';' -exec rm '{}' ';'

#    may_slinks=""
#    may_slinks=$(ls | grep thumbdrive_)
#    may_scount=$(ls | grep thumbdrive_ | wc -l)
#    echo "COunt = ${may_scount}"

#    echo "May be symbolic links " ${may_slinks[1]}
#    if [ $may_scount -ne 0 ]; then
#        echo "Inside if"
#        for s in "${may_slinks}"; do
#            echo "${sharedirve}/$s"
#	        if [ -e "${sharedirve}/$s" ]; then
#                echo "GUO GUO GUO"
#                unlink "${sharedirve}/$s"
#                rm "${sharedirve}/$s"
#            else
#                echo "LI LI LI"
#            fi
#        done
#    else
#        printf "${COLOR_RED} NO Symblolic Link for thumbdrive exist !!! ${COLOR_OFF}\n"
#    fi
fi
exit 
