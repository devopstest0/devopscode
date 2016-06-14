#!/bin/bash 


# Update tomcat_home variable 
export TOMCAT_HOME=/opt/apps/apache-tomcat-deploy/

BUILD=`md5sum /opt/apps/jenkins_home/jobs/Build/lastSuccessful/archive/target/helloproject.war|awk -F" " '{print $1}'`
DEPLOY=`md5sum ${TOMCAT_HOME}/webapps/helloproject.war|awk -F" " '{print $1 }'`

if [ ${BUILD} != ${DEPLOY} ] 
then
# Remove old war file 
rm -rf ${TOMCAT_HOME}/webapps/helloproject*

# Update latest war 
cp -r /opt/apps/jenkins_home/jobs/Build/lastSuccessful/archive/target/helloproject.war ${TOMCAT_HOME}/webapps/

# Restart tomcat 
cd ${TOMCAT_HOME}/bin/ && BUILD_ID=DoNotKill && ./shutdown.sh
sleep 10  
cd ${TOMCAT_HOME}/bin/ && BUILD_ID=DoNotKill && ./startup.sh 

else 

echo " Latest code is deployed " 

fi 
