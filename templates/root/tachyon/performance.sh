#!/usr/bin/env bash

# export AMI_PUBLIC_DNS=`wget -q -O - http://instance-data.ec2.internal/latest/meta-data/public-hostname`

cd /root/tachyon;

mkdir -p results;

task=1
mem_size=40g

MASTER_IP={{active_master}}:19998

for i in {0..31}
do
  j=$(($i*1))
  echo java -Xmx$mem_size -Xms$mem_size -cp target/tachyon-0.3.0-SNAPSHOT-jar-with-dependencies.jar \
    tachyon.examples.Performance $MASTER_IP /performance 262144 4096 false 1 2 $task $j "&> results/Task_$task\_$i.txt" \&
  java -Xmx$mem_size -Xms$mem_size -cp target/tachyon-0.3.0-SNAPSHOT-jar-with-dependencies.jar \
    tachyon.examples.Performance $MASTER_IP /performance 262144 4096 false 1 2 $task $j &> results/Task_$task\_$i.txt &
done

# ./bin/format.sh ; ./bin/start-local.sh
# grep "Current System Time" * | cut -f1,5,6,38 -d' ' | cut -f2 -d' ' | awk '{s+=$1} END {print s}'