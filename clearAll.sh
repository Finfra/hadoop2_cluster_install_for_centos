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

echo ---- claerAll.sh start-----------------------------------------------
hostCnt=$(grep -c ".*" ~/_setting_h2/host)
for i in `seq 1 $hostCnt`;do
    if [ $i -ne 1 ];then
        f=`sshpass -f ~/.ssh/pass ssh -q s$i 'ls -als |grep _setting_h2'`
        if [ ${#f} -ne 0 ]; then
            sshpass -f ~/.ssh/pass ssh -q s$i 'rm -rf ~/_setting_h2'
        fi
    fi
    if [ 'root' = `whoami` ]; then
        f=`sshpass -f ~/.ssh/pass ssh -q s$i 'ls ~/.ssh|grep authorized_keys'`
        if [ ${#f} -ne 0 ]; then
            sshpass -f ~/.ssh/pass ssh -q s$i 'rm ~/.ssh/authorized_keys'
        fi
    else
        f=`sshpass -f ~/.ssh/pass ssh -q s$i 'ls ~/.ssh|grep authorized_keys'`
        if [ ${#f} -ne 0 ]; then
            sshpass -f ~/.ssh/pass ssh -q s$i 'rm ~/.ssh/authorized_keys'
        fi
    fi
 done
echo ---- claerAll.sh end-------------------------------------------------
