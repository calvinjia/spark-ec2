#!/bin/bash

pushd /root

if [ -d "zookeeper" ]; then
  echo "Zookeeper seems to be installed. Exiting."
  exit 0
fi

echo "Setting up Zookeeper 3.4.5"
wget http://apache.claz.org/zookeeper/zookeeper-3.4.5/zookeeper-3.4.5.tar.gz ;
tar -xzvf zookeeper-3.4.5.tar.gz ;
rm zookeeper-3.4.5.tar.gz ;

echo "Finished setting up Zookeeper 3.4.5"

popd
