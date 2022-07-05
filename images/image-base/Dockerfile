FROM ubuntu

RUN apt-get update && apt-get install -y openssh-server nano iputils-ping dnsutils telnet openjdk-8-jdk
# wget bzip2

RUN groupadd hadoop && \
	useradd -d /home/hadoop -g hadoop -m hadoop --shell /bin/bash

# SSH without key
RUN mkdir /home/hadoop/.ssh
RUN ssh-keygen -t rsa -f /home/hadoop/.ssh/id_rsa -P '' && \
    cat /home/hadoop/.ssh/id_rsa.pub >> /home/hadoop/.ssh/authorized_keys

ARG HADOOP_VERSION=3.3.3
ARG SPARK_VERSION=3.3.0
ARG SCALA_VERSION=2.11.8

ENV HADOOP_HOME=/usr/local/hadoop
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Installing Hadoop
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz && \
	tar -xf hadoop-$HADOOP_VERSION.tar.gz && \
	mv hadoop-$HADOOP_VERSION $HADOOP_HOME && \
 	rm hadoop-$HADOOP_VERSION.tar.gz

# Hadoop configuration
COPY config/ssh_config /home/hadoop/.ssh/config
COPY init-scripts/init-hadoop.sh $HADOOP_HOME/bin/init/
COPY config/hdfs-site.xml config/core-site.xml \
     config/mapred-site.xml config/yarn-site.xml \
     config/hadoop-env.sh \
     $HADOOP_CONF_DIR/

# Installing Scala
RUN wget http://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz && \
 	tar -xzvf scala-${SCALA_VERSION}.tgz -C /usr/local/ && \
	mv /usr/local/scala-${SCALA_VERSION} /usr/local/scala && \
	chown -R root:root /usr/local/scala
ENV SCALA_HOME=/usr/local/scala

# Installing Spark
RUN wget http://apache.mirror.anlx.net/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-without-hadoop.tgz && \
	tar -xzvf spark-${SPARK_VERSION}-bin-without-hadoop.tgz -C /usr/local/ && \
	mv /usr/local/spark-${SPARK_VERSION}-bin-without-hadoop /usr/local/spark
ENV SPARK_HOME=/usr/local/spark
ENV LD_LIBRARY_PATH=$HADOOP_HOME/lib/native/:$LD_LIBRARY_PATH

# Spark configuration
COPY config/spark-env.sh $SPARK_HOME/conf/spark-env.sh

# Giving permissions to Hadoop user
RUN chown -R hadoop:hadoop $HADOOP_HOME && \
	chown -R hadoop:hadoop /home/hadoop

# Setting the PATH environment variable globally and for the Hadoop user
ENV PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SCALA_HOME/bin:$SPARK_HOME/bin
RUN echo "PATH=$PATH:$JAVA_HOME/bin:/usr/local/hadoop/bin:/usr/local/hadoop/sbin:$SCALA_HOME/bin:$SPARK_HOME/bin" >> /home/hadoop/.bashrc

ENTRYPOINT [ "sh", "-c", "service ssh start; $HADOOP_HOME/bin/init/init-hadoop.sh; bash"]
