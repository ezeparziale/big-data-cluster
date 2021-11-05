#!/bin/bash

# Detener Spark Distribuido
# Spark
if [ "${SPARK_TYPE}" == "master" ]; then
  printf "Hello %s\n" "$(hostname)"
  $SPARK_HOME/sbin/stop-master.sh
  printf "marter spark stopped\n"
  jps
  sleep 1
fi
if [ "${SPARK_TYPE}" == "worker" ]; then
  printf "Hello %s\n" "$(hostname)"
  $SPARK_HOME/sbin/stop-worker.sh
  printf "worker spark stopped\n"
  jps
  sleep 1
fi