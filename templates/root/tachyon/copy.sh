#!/usr/bin/env bash

SLAVES=(
{{slave_list}}
)

mkdir -p /root/tachyon/results

for host in ${SLAVES[*]}
do
  # echo $host
  scp $host:/root/tachyon/results/* /root/tachyon/results/.
done
