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
x=`rpm -qa|grep java-1.7.0-openjdk-devel`
if [ ${#x} -eq 0 ];then
	yum -y install java-1.7.0
	yum -y install java-1.7.0-openjdk-devel
fi

x=`rpm -qa|grep jna`
# Description
if [ ${#x} -eq 0 ]; then
        yum -y install jna
fi
x=`cat /etc/profile|grep JAVA_HOME|grep java-1.7.0`
if [ ${#x} -eq 0 ]; then
    echo export JAVA_HOME=`cat /root/_setting/javaHome`>>/etc/profile
fi
export JAVA_HOME=`cat /root/_setting/javaHome`

jn=`echo 1|alternatives --config java |grep java-1.7.0|awk 'BEGIN{FIELDWIDTHS = "3 4" }{print $2}'`
echo $jn|alternatives --config java > /dev/null
