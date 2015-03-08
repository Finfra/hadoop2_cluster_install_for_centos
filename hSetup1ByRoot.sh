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
echo --hSetup1Root.sh Start-----------------------------------------------------
x=`rpm -qa|grep java-1.6.0`
if [ ${#x} -eq 0 ];then 
	yum -y install  java
fi

#네임노드만 하둡 설치 받음.
if [ $1 = 'namenode' ];then
	if [ ! -e /root/hadoop-2.4.0.tar.gz_org ]	;	then
		wget https://archive.apache.org/dist/hadoop/core/hadoop-2.4.0/hadoop-2.4.0.tar.gz
		mv /root/_setting/hadoop-2.4.0.tar.gz /root/
		cp -f /root/hadoop-2.4.0.tar.gz /root/hadoop-2.4.0.tar.gz_org 
	else
		#echo 'adoop-2.4.1.tar.gz_org is exist.'
		if [ ! -e /root/hadoop-2.4.0.tar.gz ]	;	then
			cp -f /root/hadoop-2.4.0.tar.gz_org /root/hadoop-2.4.0.tar.gz
		# else
		# 	echo 'hadoop-2.4.0.tar.gz is exist.'
		fi	
	fi
fi


x=`ps -ef | grep hadoop | grep -v grep`
if [ ${#x} -gt 0 ];then 
	ps -ef | grep hadoop | grep -v grep | awk '{print $2}'|xargs kill -9 
fi

userdel -r hadoop
useradd hadoop
cat ~/_setting/password|passwd --stdin hadoop >/tmp/null
x=`cat ~hadoop/.bashrc|grep HADOOP_PREFIX`
#echo $javaHome
if [[ ${#x} -eq 0 ]]; then
	echo "# Hadoop"                                         >>~hadoop/.bashrc
	echo 'export HADOOP_PREFIX="/data/hadoop/hadoop-2.4.0"' >>~hadoop/.bashrc                                               
	echo "export PATH=\$PATH:\$HADOOP_PREFIX/bin"           >>~hadoop/.bashrc                                                 
	echo "export PATH=\$PATH:\$HADOOP_PREFIX/sbin"          >>~hadoop/.bashrc                                                  
	echo "export HADOOP_MAPRED_HOME=\${HADOOP_PREFIX}"      >>~hadoop/.bashrc                                                       
	echo "export HADOOP_COMMON_HOME=\${HADOOP_PREFIX}"      >>~hadoop/.bashrc                                                       
	echo "export HADOOP_HDFS_HOME=\${HADOOP_PREFIX}"        >>~hadoop/.bashrc                                                     
	echo "export YARN_HOME=\${HADOOP_PREFIX}"               >>~hadoop/.bashrc                                              
	echo "export YARN_HOME=\${HADOOP_PREFIX}"               >>~hadoop/.bashrc                                              
	echo "export PATH=\${PATH}:${HADOOP_PREFIX}/bin"        >>~hadoop/.bashrc                                              
	echo "export JAVA_HOME=$javaHome"                       >>~hadoop/.bashrc                                              
fi

. ~/_setting/jdkSettingAll.sh 

rm -rf /home/hadoop/.ssh
su -  hadoop --command="ssh-keygen -t rsa -q -f ~/.ssh/id_rsa -N ''"
su -  hadoop --command="echo 'StrictHostKeyChecking no'>>~/.ssh/config"
su -  hadoop --command="chmod 644 ~/.ssh/config"
su -  hadoop --command="cat /home/hadoop/.ssh/id_rsa.pub >> /home/hadoop/.ssh/authorized_keys"
su -  hadoop --command="chmod 0600 ~/.ssh/authorized_keys"


rm -rf /tmp/hadoop-hadoop-*
rm -rf /data/hadoop
mkdir -p /data/hadoop
chmod 777 /data
#echo -------------------------------------------------------
tar -xf /root/hadoop-2.4.0.tar.gz -C /root
mv /root/hadoop-2.4.0 /data/hadoop/
chown -R hadoop:hadoop /data/hadoop/
chmod 755 /root
chmod -R 755 /root/_setting
if [ $1 = 'namenode' ];then
	echo '---------   namenode '$1
	sshpass -f ~/.ssh/pass ssh hadoop@s1 . /root/_setting/hSetup2ByHadoop.sh namenode
else
	echo '---------not namenode '$1
	sshpass -f ~/.ssh/pass ssh hadoop@s$1 . /root/_setting/hSetup2ByHadoop.sh $1
fi


echo --hSetup1Root.sh End-----------------------------------------------------