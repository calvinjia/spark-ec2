#!/usr/bin/env bash

# Set Spark environment variables for your site in this file. Some useful
# variables to set are:
# - MESOS_NATIVE_LIBRARY, to point to your Mesos native library (libmesos.so)
# - SCALA_HOME, to point to your Scala installation
# - SPARK_CLASSPATH, to add elements to Spark's classpath
# - SPARK_JAVA_OPTS, to add JVM options
# - SPARK_MEM, to change the amount of memory used per node (this should
#   be in the same format as the JVM's -Xmx option, e.g. 300m or 1g).
# - SPARK_LIBRARY_PATH, to add extra search paths for native libraries.

export SCALA_HOME={{scala_home}}

# Set Spark's memory per machine; note that you can also comment this out
# and have the master's SPARK_MEM variable get passed to the workers.
export SPARK_MEM={{default_spark_mem}}

# Set JVM options and Spark Java properties
SPARK_JAVA_OPTS+=" -Dspark.local.dir={{spark_local_dirs}}"
SPARK_JAVA_OPTS+=" -Dspark.tachyon.address={{active_master}}:19998"

# On EC2, change the local.dir to /mnt/tmp
#export AGENT_OPTS="-agentpath:/home/greyreef/yjp-12.0.5/bin/linux-x86-64/libyjpagent.so"
#export DEBUG_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8787"
#SPARK_JAVA_OPTS=" $AGENT_OPTS "
#SPARK_JAVA_OPTS=" -Dspark.serializer=spark.JavaSerializer "
JVM_TUNING_OPTS=" -XX:+UnlockExperimentalVMOptions -XX:+AggressiveOpts -XX:+DoEscapeAnalysis -XX:+UseCompressedOops -XX:NewRatio=3 -XX:+UseG1GC"
SPARK_JAVA_OPTS+=" $JVM_TUNING_OPTS -XX:-UseSplitVerifier -XX:ReservedCodeCacheSize=256m -XX:MaxPermSize=2g "
SPARK_JAVA_OPTS+=" -Dspark.kryoserializer.buffer.mb=10 -Dspark.storage.memoryFraction=0.9 -Dspark.storage.blockManagerHeartBeatMs=10000 -Dspark.locality.wait=40000 "
SPARK_JAVA_OPTS+=" -verbose:gc -XX:-PrintGCDetails -XX:+PrintGCTimeStamps "

export SPARK_JAVA_OPTS

export HADOOP_HOME="/root/ephemeral-hdfs"
export SPARK_LIBRARY_PATH="/root/ephemeral-hdfs/lib/native/"
export SPARK_MASTER_IP={{active_master}}
export MASTER=`cat /root/spark-ec2/cluster-url`
export SPARK_CLASSPATH=$SPARK_CLASSPATH":/root/ephemeral-hdfs/conf"
