#!/bin/bash

pushd /root

if [ -d "tachyon" ]; then
  echo "Tachyon seems to be installed. Exiting."
  exit 0
fi

echo "Setuping maven 3.0.5"
wget http://apache.claz.org/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz ;
tar -xzvf apache-maven-3.0.5-bin.tar.gz ;
mv apache-maven-3.0.5 maven ;
rm apache-maven-3.0.5-bin.tar.gz ;
echo "export M2_HOME=/root/maven" >> .bashrc ;
echo "export M2=\$M2_HOME/bin" >> .bashrc ;
echo "export MAVEN_OPTS=\"-Xms512m -Xmx1024m\"" >> .bashrc ;
echo "export PATH=\$M2:\$PATH" >> .bashrc ;
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0" >> .bashrc ;
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> .bashrc;
source .bashrc;

# echo "Setuping apache thrift 0.7"
# yum -y install automake libtool flex bison pkgconfig gcc-c++ boost-devel libevent-devel zlib-devel python-devel ruby-devel ant python-dev
# wget http://archive.apache.org/dist/thrift/0.7.0/thrift-0.7.0.tar.gz
# tar -xzvf thrift-0.7.0.tar.gz
# rm thrift-0.7.0.tar.gz
# cd thrift-0.7.0
# chmod a+x configure
# ./configure
# make
# make install

echo "Setuping tachyon"
git clone https://github.com/calvinjia/tachyon.git
cd tachyon
git checkout master
mvn install -DskipTests

popd
