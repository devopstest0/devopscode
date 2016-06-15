#!/bin/bash 


BUILD=`md5sum ${WORKSPACE}/packages/target/helloproject.war|awk -F" " '{print $1}'`

if [ -f ${TOMCAT_HOME}/webapps/helloproject.war ]
then
DEPLOY=`md5sum ${TOMCAT_HOME}/webapps/helloproject.war|awk -F" " '{print $1 }'`
fi

if [ ! -f ${TOMCAT_HOME}/webapps/helloproject.war ] || [ ${BUILD} != ${DEPLOY} ]
then
# Remove old war file 
rm -rf ${TOMCAT_HOME}/webapps/helloproject*

# Update latest war 
cp -r ${WORKSPACE}/packages/target/helloproject.war  ${TOMCAT_HOME}/webapps/

# Restart tomcat 
cd ${TOMCAT_HOME}/bin/ && BUILD_ID=DoNotKill && ./shutdown.sh
sleep 10  
cd ${TOMCAT_HOME}/bin/ && BUILD_ID=DoNotKill && ./startup.sh 

else 

echo " Latest code is deployed " 

fi 
