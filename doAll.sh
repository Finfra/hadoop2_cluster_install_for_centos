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

echo "## doAll.sh start ###################################################"
cd ~/_setting_h2
#Set Variable
hostCnt=$(grep -c ".*" host)
if [ 'root' = `whoami` ]; then
         . ~/_setting_h2/setHost.sh
fi
. ~/_setting_h2/installSshpass.sh
. ~/_setting_h2/clearAll.sh
. ~/_setting_h2/keySend.sh

for i in `seq 2 $hostCnt`; do
        echo "### Setting started For Slaves(s$i) ##################################"

        sshpass -f ~/.ssh/pass ssh s$i mkdir ~/_setting_h2
        sshpass -f ~/.ssh/pass scp ~/_setting_h2/*  s$i:~/_setting_h2/

        sshpass -f ~/.ssh/pass scp ~/_setting_h2/setHost.sh  s$i:~/_setting_h2/
        sshpass -f ~/.ssh/pass ssh s$i . ~/_setting_h2/setHost.sh

        sshpass -f ~/.ssh/pass ssh s$i . ~/_setting_h2/installSshpass.sh
        sshpass -f ~/.ssh/pass ssh s$i . ~/_setting_h2/keySend.sh
        echo "### Setting ended For Slaves(s$i) ####################################"
done

echo "## doAll.sh ended ####################################################"
