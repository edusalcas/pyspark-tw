FROM hadoop-base

RUN mkdir -p /data/hdfs/namenode && \
	chown -R hadoop:hadoop /data && \
	chown -R hadoop:hadoop $HADOOP_CONF_DIR/workers

VOLUME /config
RUN rm $HADOOP_CONF_DIR/workers && ln -s /config/workers $HADOOP_CONF_DIR/workers

ENTRYPOINT [ "sh", "-c", "service ssh start; $HADOOP_HOME/bin/init/init-hadoop.sh; bash"]
