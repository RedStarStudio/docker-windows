docker build -t robertma/robotframework .
rem you should replace username and password as your own. make sure you have the write permission. 
docker login 
docker push robertma/robotframework
