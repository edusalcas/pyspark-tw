FROM hadoop-base

RUN mkdir -p /data/hdfs/datanode && \
	chown -R hadoop:hadoop /data

ENTRYPOINT [ "sh", "-c", "service ssh start; $HADOOP_HOME/bin/init/init-hadoop.sh; bash"]
