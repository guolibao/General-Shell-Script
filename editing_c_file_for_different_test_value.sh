#!/bin/bash
for i in {1..1}
do
	echo "another cycle $i, sleep 2 seconds first"
	echo ""
	sleep 2
	sed -i '375d' platform/tcc892x/tcc_ddr.c
	sed -i '375s/\///g' platform/tcc892x/tcc_ddr.c
	name=$(sed -n '375s/    denali_phy(0x14) = 0x\(.*\);/\1/p' platform/tcc892x/tcc_ddr.c)
	echo $name

	git commit -am "$name"
	git push origin dev-guo

	echo "pushed to server already $name"
	echo "sleep 5 seconds"
	sleep 5

	cd /home/guo/works/JKTS_Pentas_Yocto/release/buildscripts/18DDX_8925
	./jk_build_lk.sh re

	echo "build finish, sleep 5 seconds "
	sleep 5


	lkFile=/home/guo/works/JKTS_Pentas_Yocto/release/build/jk_18ddx_8925/tmp/deploy/images/tcc8925-jk/lk-18DDX_8925.rom
	#/home/guo/wkspace/tcc8925_jk
	windows_lk=~/wkspace/tcc8925_jk/lk-18DDX_8925_${name}.rom

	echo "copy file $name"
	cp $lkFile $windows_lk
	cd -
done
