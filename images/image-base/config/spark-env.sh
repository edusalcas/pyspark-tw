export HADOOP_HOME=/usr/local/hadoop/
export PATH=$PATH:$HADOOP_HOME/bin
export SPARK_DIST_CLASSPATH=$(hadoop classpath)