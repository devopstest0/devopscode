#!/bin/bash 

# Installation And configuration of Tomcat on 36-Ubuntu 
# Script must be run from root

APP_HOME=/opt/apps
TOMCAT_HOME=/opt/apps/apache-tomcat-7.0.69
JAVA_HOME=/opt/apps/jdk1.7.0_79
INSTALLER_LOCATION=/vagrant/installers


# Function will install JDK 7 
function jdk_install()
{
if [ ! -d ${JAVA_HOME} ] 
then
mkdir -p $APP_HOME && cd $APP_HOME && tar -vxf ${INSTALLER_LOCATION}/jdk-7u79-linux-x64.tar 
fi 
}

# Function will install Tomcat 7 
function tomcat_install()
{
if [ ! -d ${TOMCAT_HOME} ] 
then
mkdir -p $APP_HOME && cd $APP_HOME && tar -xvzf ${INSTALLER_LOCATION}/apache-tomcat-7.0.69.tar.gz
else 
echo Tomcat is already installed. no action needed.
fi
}

# Function will Start tomcat server
function tomcat_start()
{
ps -aef|grep ${TOMCAT_HOME}|grep -v grep | grep start >/dev/null
if [ $? -eq 0 ] 
then
echo "INFO: Tomcat is already running"
else
echo "INFO: Starting tomcat server "
export JAVA_HOME=/opt/apps/jdk1.7.0_79
export PATH=$JAVA_HOME/bin:$PATH
/opt/apps/apache-tomcat-7.0.69/bin/startup.sh 
fi

}



jdk_install
tomcat_install
tomcat_start
