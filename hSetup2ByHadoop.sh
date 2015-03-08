#!/bin/bash
#
# Copyright (c) 2009-2014 finfra.com <nowage@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

echo ----hSetup2Hadoop.sh start---------------------------------------------------
## clear

rm -rf /data/hadoop/dfs/name
rm -rf /data/hadoop/dfs/data
rm -rf /data/hadoop/dfs/mapred

. .bashrc
javaHome=`cat /root/_setting/javaHome`
echo $javaHome
echo "export JAVA_HOME="$javaHome>>/data/hadoop/hadoop-2.4.0/etc/hadoop/hadoop-env.sh
echo "export HADOOP_COMMON_LIB_NATIVE_DIR=\${HADOOP_PREFIX}/lib/native">>/data/hadoop/hadoop-2.4.0/etc/hadoop/hadoop-env.sh
echo 'export HADOOP_OPTS="-Djava.library.path=\$HADOOP_PREFIX/lib"'>>/data/hadoop/hadoop-2.4.0/etc/hadoop/hadoop-env.sh
echo "export HADOOP_COMMON_LIB_NATIVE_DIR=\${HADOOP_PREFIX}/lib/native">>/data/hadoop/hadoop-2.4.0/etc/hadoop/yarn-env.sh
echo 'export HADOOP_OPTS="-Djava.library.path=\$HADOOP_PREFIX/lib"'>>/data/hadoop/hadoop-2.4.0/etc/hadoop/yarn-env.sh


cat >/data/hadoop/hadoop-2.4.0/etc/hadoop/core-site.xml<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
 <property>
   <name>fs.default.name</name>
   <value>hdfs://s1:9000</value>
   <final>true</final>
 </property>
   <property>
    <name>hadoop.tmp.dir</name>
    <value>/tmp/hadoop2.4</value>
  </property>
</configuration>
EOF
cat >/data/hadoop/hadoop-2.4.0/etc/hadoop/yarn-site.xml<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property>
  <property>
    <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
    <value>org.apache.hadoop.mapred.ShuffleHandler</value>
  </property>
  <property>
    <name>yarn.resourcemanager.resource-tracker.address</name>
    <value>s1:8025</value>
  </property>
  <property>
    <name>yarn.resourcemanager.scheduler.address</name>
    <value>s1:8030</value>
  </property>
  <property>
    <name>yarn.resourcemanager.address</name>
    <value>s1:8040</value>
  </property>
</configuration>
EOF

cat >/data/hadoop/hadoop-2.4.0/etc/hadoop/hdfs-site.xml<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
<property>
  <name>dfs.replication</name>
  <value>1</value>
</property>
<property>
  <name>dfs.permissions</name>
  <value>false</value>
</property>
 <property>
   <name>dfs.namenode.name.dir</name>
   <value>file:/data/hadoop/dfs/name</value>
   <final>true</final>
 </property>
 <property>
   <name>dfs.datanode.data.dir</name>
   <value>file:/data/hadoop/dfs/data</value>
   <final>true</final>
 </property>
 <property>
   <name>dfs.permissions</name>
   <value>false</value>
 </property>
</configuration>
EOF


cat >/data/hadoop/hadoop-2.4.0/etc/hadoop/mapred-site.xml<<EOF
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
 <property>
   <name>mapreduce.framework.name</name>
   <value>yarn</value>
 </property>
 <property>
   <name>mapred.system.dir</name>
   <value>file:/data/hadoop/mapred/system</value>
   <final>true</final>
 </property>
 <property>
   <name>mapred.local.dir</name>
   <value>file:/data/hadoop/mapred/local</value>
   <final>true</final>
 </property>
</configuration>
EOF

if [ -f /data/hadoop/hadoop-2.4.0/etc/hadoop/masters ];then
	rm /data/hadoop/hadoop-2.4.0/etc/hadoop/masters
fi
touch /data/hadoop/hadoop-2.4.0/etc/hadoop/masters
cat >/data/hadoop/hadoop-2.4.0/etc/hadoop/masters<<EOF
s1
EOF

if [ -f /data/hadoop/hadoop-2.4.0/etc/hadoop/slaves ];then
	rm /data/hadoop/hadoop-2.4.0/etc/hadoop/slaves
fi
touch /data/hadoop/hadoop-2.4.0/etc/hadoop/slaves
hostCnt=$(grep -c ".*" /root/_setting/host)
for i in `seq 1 $hostCnt`
do
	x=`cat /data/hadoop/hadoop-2.4.0/etc/hadoop/slaves|grep s$i`
	if [ ${#x} -eq 0 ] ;then 
		echo "s$i">>/data/hadoop/hadoop-2.4.0/etc/hadoop/slaves
	fi
done



echo ----hSetup2Hadoop.sh stop---------------------------------------------------
