#!/usr/bin/env bash

# export AMI_PUBLIC_DNS=`wget -q -O - http://instance-data.ec2.internal/latest/meta-data/public-hostname`

cd /root/tachyon;

mkdir -p results;

task=5

MASTER_IP=localhost

for i in {0..1}
do
  j=$(($i*1))
  echo java -Xmx20g -Xms20g -cp target/tachyon-0.3.0-SNAPSHOT-jar-with-dependencies.jar \
    tachyon.examples.PerformanceTest $MASTER_IP /performance 262144 4096 false 1 1 $task $j "&> results/$i.txt" \&
  java -Xmx20g -Xms20g -cp target/tachyon-0.3.0-SNAPSHOT-jar-with-dependencies.jar \
    tachyon.examples.PerformanceTest $MASTER_IP /performance 262144 4096 false 1 1 $task $j &> results/$i.txt &
done

# ./bin/format.sh ; ./bin/start-local.sh
# grep "Current System Time" * | cut -f1,5,6,38 -d' ' | cut -f2 -d' ' | awk '{s+=$1} END {print s}'