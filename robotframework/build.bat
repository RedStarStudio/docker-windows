docker build -t robotframework --build-arg HTTPS_PROXY=http://10.88.33.116:31288 .
docker tag robotframework ged-docker-l.production-cn.artifactory.bshg.com/common/robotframework:windows-2.7.15
rem you should replace username and password as your own. make sure you have the write permission. 
docker login ged-docker-l.production-cn.artifactory.bshg.com 
docker push ged-docker-l.production-cn.artifactory.bshg.com/common/robotframework:windows-2.7.15
