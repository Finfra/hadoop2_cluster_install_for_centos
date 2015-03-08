# hadoop2_cluster_install_for_centos - Introduction

This is hadoop2 cluster installer for centos.

# Version

v1.0.1

# Intall hadoop2.4 with hadoop2_cluster_install_for_centos.
step1. check yum update for all node<br>
    # yum update -y<br>
step2. download <br>
    # cd <br>
    # wget https://github.com/Finfra/hadoop2_cluster_install_for_centos/archive/master.zip<br>
    # mv hadoop2_cluster_install_for_centos  _setting<br>
setp3. change setting file.<br>
    # vi password      (All node's password will be equal.)<br>
    # vi host          (Use ip addresses not url or nostname.)<br>
step4. run install script.<br>
    # cd /root/_setting       <br>                  
    # .hSetupAll.sh<br>
step5. check.<br>
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
This is early version,so these code many bug, but if u have correct version of java,then it will be works good.

# BUGS
    
Please report bugs to nowage[at]icloud.com.

# todo

make dynamic setting for java version, password for each node,,,

# CONTRIBUTING

The github repository is at https://github.com/Finfra/hadoop2_cluster_install_for_centos

# SEE ALSO

Some other stuff.

# AUTHOR

NamJungGu, <nowage[at]gmail.com>

# COPYRIGHT AND LICENSE

(c) Copyright 2005-2015 by finfra.com
