#!/bin/bash 

# Installation And configuration of APache2 on 36-Ubuntu 
# Script must be run from root

PKG_LIST="apache2, libapache2-mod-jk"
WEB_HOME="/etc/apache2"
SCRIPT_HOME=/opt/sourcecode/devopscode/scripts/web/

function apache2_install()
{
apt-get install ${PKG_LIST}

}


# Below function will update apache2 configuration and integrate it with tomcat
function apache2_config()
{
cd ${SCRIPT_HOME} && cp -r config/* ${WEB_HOME}/

# Restart apache server
service apache2 restart 

}


apache2_install
apache2_config
