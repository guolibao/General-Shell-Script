#!/bin/sh

APPDIR=$1
OUTPUTDIR=$2
APPROM_IMG_NAME=$3
APPROM_SIZE=$4

echo "=========================================================="
echo "approm image(ext4) create tool Ver.2"
echo "=========================================================="

img_creation_func() {
	FILEPATH="$(cd $(dirname $0) && pwd)"

	if [ -z $APPDIR ]; then
		echo "error: few arguments. please set approm_directory!"
		echo "[USAGE] create_approm.sh <approm_directory> <output_directory> [<image_name>] [<image_size(KB)>]"
		return
	fi

	# 末尾の/を消去する
	$APPDIR = $(echo $APPDIR | sed -e 's/\/$//g')

	if [ -z $OUTPUTDIR ]; then
		echo "error: few arguments. please set output directory!"
		echo "[USAGE] create_approm.sh <approm_directory> <output_directory> [<image_name>] [<image_size(KB)>]"
		return
	fi

	# 末尾の/を消去する
	$OUTPUTDIR = $(echo $OUTPUTDIR | sed -e 's/\/$//g')

	if [ ! -e $OUTPUTDIR ]; then
		mkdir $OUTPUTDIR
	fi

	if [ -z $APPROM_IMG_NAME ]; then
		APPROM_IMG_NAME="lily-bb-approm"
	fi

	if [ -z $APPROM_SIZE ]; then
		APPROM_SIZE="327680"
	fi

	echo "=========================================================="
	echo "script path = $FILEPATH"
	echo "approm path = $APPDIR"
	echo "approm image name = $APPROM_IMG_NAME"
	echo "approm image size = $APPROM_SIZE"
	echo "=========================================================="

	fstype="ext4"
	extra_imagecmd="-i 4096 -m 2 -b 4096"

	# 【暫定】指定したアプリディレクトリ内のPermissionを再帰的に777とする
	chmod 777 -R $APPDIR/*

	# If generating an empty image the size of the sparse block should be large
	# enough to allocate an ext4 filesystem using 4096 bytes per inode, this is
	# about 60K, so dd needs a minimum count of 60, with bs=1024 (bytes per IO)
	eval local COUNT=\"0\"
	eval local MIN_COUNT=\"60\"
	if [ $APPROM_SIZE -lt $MIN_COUNT ]; then
		eval COUNT=\"$MIN_COUNT\"
	fi

	# Create a sparse image block
	dd if=/dev/zero of=$OUTPUTDIR/$APPROM_IMG_NAME.$fstype seek=$APPROM_SIZE count=$COUNT bs=1024

	# 重複ファイルが出来る不具合有.使用禁止.
	#$FILEPATH/create_approm/bin/mkfs.$fstype -F $extra_imagecmd $OUTPUTDIR/$APPROM_IMG_NAME.$fstype -d $APPDIR

	# format
	mkfs.$fstype -F $extra_imagecmd $OUTPUTDIR/$APPROM_IMG_NAME.$fstype

	# Create a mount point
	mkdir ./mountdir

	echo "loopback mount $OUTPUTDIR/$APPROM_IMG_NAME.$fstype"

	# loop back mount
	sudo mount -o loop -t $fstype $OUTPUTDIR/$APPROM_IMG_NAME.$fstype ./mountdir

	echo "copying..."

	# マウント後も念の為、Permissionを再帰的に777とする
	sudo chmod 777 -R ./mountdir/*

	# file copy
	cp -fr $APPDIR/* ./mountdir/

	# busy状態回避のため
	sleep 1s

	echo "umount loopback device"
	# umount loop back device
	sudo umount ./mountdir
	while [ $? -ne 0 ]
	do
		sudo umount ./mountdir
	done

	# delete a mount point
	rm -rf ./mountdir
}

img_creation_func

