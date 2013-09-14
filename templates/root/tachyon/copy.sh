#!/usr/bin/env bash

SLAVES=(
{{slave_list}}
)

for host in ${SLAVES[*]}
do
  # echo $host
  scp $host:/root/tachyon/results/* /root/tachyon/results/.
done
