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

x=`rpm -qa|grep sshpass`
if [ ${#x} -eq 0 ] ; then 
	wget http://pkgs.repoforge.org/sshpass/sshpass-1.05-1.el3.rf.x86_64.rpm
	rpm -Uvh sshpass-1.05-1.el3.rf.x86_64.rpm
	rm -f sshpass-1.05-1.el3.rf.x86_64.rpm
fi
if [ -d ~/.ssh/ ]
then
	echo '.ssh exist'
else
	mkdir ~/.ssh/
	chmod 700 ~/.ssh/
fi
if [ 'root' = `whoami` ]; then
	echo #################################
	echo #################################
	echo #################################
	echo #################################
	echo #################################
	#do extra job.
    cat ~/_setting/password>~/.ssh/pass
else
	#do extra job.
	cat ~/_setting/password>~/.ssh/pass	
fi



