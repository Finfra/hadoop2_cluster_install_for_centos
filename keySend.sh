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
echo ---- keySend.sh start -----------------------------------------------

if [ -e ~/.ssh/id_rsa ] ;then
        rm -f ~/.ssh/id_rsa
fi
if [ -e ~/.ssh/id_rsa.pub ]     ;then
        rm -f ~/.ssh/id_rsa.pub
fi
ssh-keygen -t rsa -q -f ~/.ssh/id_rsa -N ''
if [ -f ~/.ssh/config ]; then
    x=`cat ~/.ssh/config|grep \^StrictHostKeyChecking`
fi
if [ ${#x} -eq 0 ] ;then
        echo "StrictHostKeyChecking no">>~/.ssh/config
        chmod 600 ~/.ssh/config
fi
hostCnt=$(grep -c ".*" /root/_setting_h2/host)
for i in `seq 1 $hostCnt`;do
        x=`sshpass -f ~/.ssh/pass ssh -q s$i ls -als|grep .ssh`
        if [ ${#x} -eq 0 ];then
            sshpass -f ~/.ssh/pass ssh -q s$i mkdir ~/.ssh;chmod 700 ~/.ssh
        fi
        sshpass -f ~/.ssh/pass scp -q ~/.ssh/id_rsa.pub s$i:tmp
        sshpass -f ~/.ssh/pass ssh -q s$i touch ~/.ssh/authorized_keys
        sshpass -f ~/.ssh/pass ssh -q s$i 'cat tmp>>  ~/.ssh/authorized_keys'
        sshpass -f ~/.ssh/pass ssh -q s$i chmod 600 ~/.ssh/authorized_keys
        ssh s$i 'cat /etc/sysconfig/network|grep HOSTNAME'
done
echo ---- keySend.sh end -------------------------------------------------
