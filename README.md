# hadoop2_cluster_install_for_centos - Introduction

This is hadoop2 cluster installer for centos.

# Version

v1.0.2

# Intall hadoop2.4 with hadoop2_cluster_install_for_centos.
##step0. Preinstall
    # yum -y install wget
    # yum -y install  net-tools
    # yum -y update : yum -y update && yum -y upgrade
    # reboot
##step1. check yum update for all node
    # yum update -y
##step2. download 
    # cd 
    # wget https://github.com/Finfra/hadoop2_cluster_install_for_centos/archive/master.zip
    # mv hadoop2_cluster_install_for_centos  _setting
##setp3. change setting file.
    # vi password      (All node's password will be equal.)
    # vi host          (Use ip addresses, not url or nostname.)
##step4. run install script.
    # cd /root/_setting                         
    # .hSetupAll.sh
##step5. check.
```
# .hSetupAll.sh
            <<~ Omitted ~>>
Found 1 items
drwxr-xr-x   - hadoop supergroup          0 2015-03-08 18:14 /test
----hSetup3ByHadoop.sh end---------------------------------------------------
########################################################################
########################################################################
# su - hadoo
$ 
# Result
```

# CF        
This is early version.
Welcome our code.

# BUGS
    
Please report bugs to nowage[at]gmail.com.

# todo

password for each node,,,
download rpm only one time when sshpass install,,,

# CONTRIBUTING

The github repository is at https://github.com/Finfra/hadoop2_cluster_install_for_centos

# SEE ALSO

Some other stuff.

# AUTHOR

NamJungGu, <nowage[at]gmail.com>

# COPYRIGHT AND LICENSE

(c) Copyright 2005-2015 by finfra.com
