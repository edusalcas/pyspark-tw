docker rmi hadoop-base hadoop-datanode hadoop-namenode

cd images/image-base
docker build --tag hadoop-base .
