#!/bin/bash 

#create mount dirs
sudo mkdir -pv $LFS/{dev,proc,sys,run}
mount -v --bind /dev $LFS/dev

#mount virtual kernel systems
mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run


#symbolic link to /run/shm
if [ -h $LFS/dev/shm ]; then
	mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi

#chroot into the lfs environment
chroot "$LFS" /tools/bin/env -i \
HOME=/root \
TERM="$TERM" \
PS1='(lfs chroot) \u:\w\$ ' \
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
/tools/bin/bash --login +h



