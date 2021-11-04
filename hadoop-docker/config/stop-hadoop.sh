#!/bin/bash

# Detener Hadoop Pseudo-distribuido
if [ "${HADOOP_PSEUDO_MODE}" == "1" ]; then
  $HADOOP_HOME/bin/hdfs --daemon stop namenode
  $HADOOP_HOME/bin/hdfs --daemon stop datanode
  $HADOOP_HOME/bin/hdfs --daemon stop secondarynamenode
  $HADOOP_HOME/bin/yarn --daemon stop resourcemanager
  $HADOOP_HOME/bin/yarn --daemon stop nodemanager
  $HADOOP_HOME/bin/mapred --daemon stop historyserver
  sleep 1
fi

# Detener Hadoop Distribuido
# Hadoop
if [[ "${HADOOP_TYPE}" == *"namenode"* ]]; then
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/hdfs --daemon stop namenode
  printf "namenode stopped\n"
  jps
  sleep 1
fi
if [[ "${HADOOP_TYPE}" == *"datanode"* ]]; then
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/hdfs --daemon stop datanode
  printf "datanode stopped\n"
  jps
  sleep 1
fi
if [[ "${HADOOP_TYPE}" == *"secondarynamenode"* ]]; then
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/hdfs --daemon stop secondarynamenode
  printf "secondarynamenode stopped\n"
  jps
  sleep 1
fi
if [[ "${HADOOP_TYPE}" == *"journalnode"* ]]; then
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/hdfs --daemon stop journalnode
  printf "journalnode stopped\n"
  jps
  sleep 1
fi


# Yarn
if [[ "${HADOOP_TYPE}" == *"resourcemanager"* ]]; then
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/yarn --daemon stop resourcemanager
  printf "resourcemanager stopped\n"
  jps
  sleep 1
fi
if [[ "${HADOOP_TYPE}" == *"nodemanager"* ]]; then
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/yarn --daemon stop nodemanager
  printf "nodemanager stopped\n"
  jps
  sleep 1
fi
if [[ "${HADOOP_TYPE}" == *"historyserver"* ]]; then
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/mapred --daemon stop historyserver
  printf "historyserver stopped\n"
  jps
  sleep 1
fi