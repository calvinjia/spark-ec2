#!/usr/bin/env bash

# export AMI_PUBLIC_DNS=`wget -q -O - http://instance-data.ec2.internal/latest/meta-data/public-hostname`

# cd /root/tachyon;

TACH_JAR=/root/tachyon/target/tachyon-0.3.0-SNAPSHOT-jar-with-dependencies.jar

RESULT_FOLDER=/root/tachyon/results

mkdir -p $RESULT_FOLDER

JVM_SIZE=3g

MASTER_IP={{active_master}}:19998

HOSTNAME=`hostname`

DATA_PATH="hdfs://{{active_master}}:9000/performance/$HOSTNAME-"
# DATA_PATH="/performance/$HOSTNAME-"

BLOCKS=4096
# BLOCKS=64

JAVA=/usr/lib/jvm/java-1.7.0/bin/java

for task in {1..1}
do
  sync && echo 3 > /proc/sys/vm/drop_caches
  for i in {0..31}
  do
    j=$(($i*1))
    echo $JAVA -Xmx$JVM_SIZE -Xms$JVM_SIZE -cp $TACH_JAR tachyon.examples.Performance \
      $MASTER_IP $DATA_PATH 262144 $BLOCKS false 1 1 $task $j "&> $RESULT_FOLDER/Task_$task\_$i\_$HOSTNAME.txt" \&
    $JAVA -Xmx$JVM_SIZE -Xms$JVM_SIZE -cp $TACH_JAR tachyon.examples.Performance \
      $MASTER_IP $DATA_PATH 262144 $BLOCKS false 1 1 $task $j &> $RESULT_FOLDER/Task_$task\_$i\_$HOSTNAME.txt &
  done
  # sleep 1
done

# grep "Current System Time" Task_1_* | cut -f1,5,6,38 -d' ' | cut -f2 -d' ' | awk '{s+=$1} END {print s}'

# grep "Exception" *

# for i in {1..6}
# do
#   grep "Current System Time" Task_"$i"_* | cut -f1,5,6,38 -d' ' | cut -f2 -d' ' | awk '{s+=$1} END {print s}'
# done
