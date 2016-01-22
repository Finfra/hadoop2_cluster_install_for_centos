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

echo ----hSetup3ByHadoop.sh start---------------------------------------------------
# /data/hadoop/hadoop-$hadoopVersion/sbin/hadoop namenode -format
# /data/hadoop/hadoop-$hadoopVersion/sbin/start-all.sh
# whoami

if [ $1 = 'namenode' ];then
    if [ ${#hadoopVersion} -eq 0 ];then
            hadoopVersion=`cat /root/_setting/hadoopVersion`
    fi
	cd /data/hadoop/;hdfs namenode -format
	start-all.sh
	hadoop fs -mkdir /test
	hadoop fs -ls /
	# hadoop fs -mkdir /test
	# ls >a.txt
	# hadoop fs -copyFromLocal ./a.txt /test
	# hadoop fs -ls /test
	#hadoop jar /data/hadoop/hadoop-$hadoopVersion/share/hadoop/mapreduce/hadoop-mapreduce-examples-$hadoopVersion.jar pi 10 10
fi
# http://s1:8088/
# http://s1:50090/
# http://s1:50010/
# http://s1:50075/
# http://s1:50020/
# http://s1:50070/
# http://s1:50030/
# http://s1:50060/


echo ----hSetup3ByHadoop.sh end---------------------------------------------------
