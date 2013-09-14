#!/usr/bin/env bash

FOLDERS=(/mnt/hadoop/tmp)
SIZE=1g

for F in ${FOLDERS[*]}
do
  umount -f $F ; mkdir -p $F; mount -t tmpfs -o size=$SIZE tmpfs $F ; chmod a+w $F ;
  # sudo umount -f $F ; sudo mkdir -p $F; sudo mount -t tmpfs -o size=$SIZE tmpfs $F ; sudo chmod a+w $F ;
done
