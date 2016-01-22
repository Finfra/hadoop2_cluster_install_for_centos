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
if [ ${#hadoopVersion} -eq 0 ];then
        hadoopVersion=`cat /root/_setting_h2/hadoopVersion`
fi



rm -rf /data/hadoop/dfs/name
rm -rf /data/hadoop/dfs/data
rm -rf /data/hadoop/dfs/mapred

. .bashrc
javaHome=`cat /root/_setting_h2/javaHome`
echo "export JAVA_HOME="$javaHome>>/data/hadoop/hadoop-$hadoopVersion/etc/hadoop/hadoop-env.sh
echo "export HADOOP_COMMON_LIB_NATIVE_DIR=\${HADOOP_PREFIX}/lib/native">>/data/hadoop/hadoop-$hadoopVersion/etc/hadoop/hadoop-env.sh
echo 'export HADOOP_OPTS="-Djava.library.path=\$HADOOP_PREFIX/lib"'>>/data/hadoop/hadoop-$hadoopVersion/etc/hadoop/hadoop-env.sh
echo "export HADOOP_COMMON_LIB_NATIVE_DIR=\${HADOOP_PREFIX}/lib/native">>/data/hadoop/hadoop-$hadoopVersion/etc/hadoop/yarn-env.sh
echo 'export HADOOP_OPTS="-Djava.library.path=\$HADOOP_PREFIX/lib"'>>/data/hadoop/hadoop-$hadoopVersion/etc/hadoop/yarn-env.sh


cat >/data/hadoop/hadoop-$hadoopVersion/etc/hadoop/core-site.xml<<EOF
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
    <value>/tmp/hadoop2.7</value>
  </property>
</configuration>
EOF
cat >/data/hadoop/hadoop-$hadoopVersion/etc/hadoop/mapred-site.xml<<EOF
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
 <property>
   <name>mapreduce.framework.name</name>
   <value>yarn</value>
 </property>
</configuration>
EOF
 #  <property>
 #   <name>mapred.child.java.opts</name>
 #   <value>-Xmx400m</value>
 # </property>
 # <property>
 #   <name>mapred.system.dir</name>
 #   <value>file:/data/hadoop/mapred/system</value>
 #   <final>true</final>
 # </property>
 # <property>
 #   <name>mapred.local.dir</name>
 #   <value>file:/data/hadoop/mapred/local</value>
 #   <final>true</final>
 # </property>

cat >/data/hadoop/hadoop-$hadoopVersion/etc/hadoop/yarn-site.xml<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
    <value>org.apache.hadoop.mapred.ShuffleHandler</value>
  </property>
  <property>
    <name>yarn.resourcemanager.hostname</name>
    <value>s1</value>
  </property>
  <property>
    <name>yarn.resourcemanager.resource-tracker.address</name>
    <value>hdfs://s1:8031</value>
  </property>
  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property>
    <property>
        <name>yarn.log-aggregation-enable</name>
        <value>true</value>
    </property>
  <property>
    <name>mapreduce.jobtracker.address</name>
    <value>s1:8021</value>
  </property>
    <property>
        <name>mapreduce.job.ubertask.enable</name>
        <value>true</value>
    </property>
    <property>
        <name>mapreduce.job.ubertask.maxbytes</name>
        <value>4096</value>
    </property>
     <property>
        <name>mapreduce.job.ubertask.maxmaps</name>
        <value>1024</value>
    </property>
    <property>
        <name>mapreduce.job.ubertask.maxreduces</name>
        <value>1024</value>
    </property>
</configuration>
EOF
# <property>
#   <name>yarn.nodemanager.container-executor.class</name>
#   <value>org.apache.hadoop.yarn.server.nodemanager.LinuxContainerExecutor</value>
# </property>

# <property>
#   <name>yarn.nodemanager.linux-container-executor.group</name>
#   <value>hadoop</value>
# </property>
cat >/data/hadoop/hadoop-$hadoopVersion/etc/hadoop/hdfs-site.xml<<EOF
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
#<property>
#   <name>yarn.nodemanager.resource.memory-mb</name>
#   <value>8192</value>
#</property>



if [ -f /data/hadoop/hadoop-$hadoopVersion/etc/hadoop/masters ];then
  rm /data/hadoop/hadoop-$hadoopVersion/etc/hadoop/masters
fi
touch /data/hadoop/hadoop-$hadoopVersion/etc/hadoop/masters
cat >/data/hadoop/hadoop-$hadoopVersion/etc/hadoop/masters<<EOF
s1
EOF

if [ -f /data/hadoop/hadoop-$hadoopVersion/etc/hadoop/slaves ];then
  rm /data/hadoop/hadoop-$hadoopVersion/etc/hadoop/slaves
fi
touch /data/hadoop/hadoop-$hadoopVersion/etc/hadoop/slaves
hostCnt=$(grep -c ".*" /root/_setting_h2/host)
for i in `seq 1 $hostCnt`;do
  x=`cat /data/hadoop/hadoop-$hadoopVersion/etc/hadoop/slaves|grep s$i`
  if [ ${#x} -eq 0 ] ;then
    echo "s$i">>/data/hadoop/hadoop-$hadoopVersion/etc/hadoop/slaves
  fi
done

if [ ! -d /data/hadoop/mapred/local ];then
  mkdir -p /data/hadoop/mapred/local;
fi

if [ ! -d /data/hadoop/mapred/system ];then
  mkdir -p /data/hadoop/mapred/system;
fi




echo ----hSetup2Hadoop.sh stop---------------------------------------------------
