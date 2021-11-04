#!/bin/bash

# Configuración de archivos de hadoop en función de las variables de entorno
function addProperty() {
  local path=$1
  local name=$2
  local value=$3

  local entry="<property><name>$name</name><value>${value}</value></property>"
  local escapedEntry=$(echo $entry | sed 's/\//\\\//g')
  sed -i "/<\/configuration>/ s/.*/${escapedEntry}\n&/" $path
}


function configure() {
    local path=$1
    local envPrefix=$2

    local var
    local value
    
    echo "Configurando: ${envPrefix,,}.xml"
    for c in `printenv | perl -sne 'print "$1 " if m/^${envPrefix}_(.+?)=.*/' -- -envPrefix=$envPrefix`; do 
        name=`echo ${c} | perl -pe 's/_____/:/g; s/____/_/g; s/___/-/g; s/__/@/g; s/_/./g;'`
        var="${envPrefix}_${c}"
        value=${!var}
        echo " - Setting $name=$value"
        addProperty $path $name "$value"
    done
}


function check_hdfs_format() {
  if [ ! -d "$HADOOP_DATA/hdfs" ]; then
    $HADOOP_HOME/bin/hdfs namenode -format
  fi
}


function check_hdfs_format_ha() {
  if [ ! -d "$HADOOP_DATA/hdfs" ]; then
    $HADOOP_HOME/bin/hdfs namenode -format
    $HADOOP_HOME/bin/hdfs zkfc -formatZK
  fi
}


function check_hdfs_bootstrapStandby() {
  if [ ! -d "$HADOOP_DATA/hdfs" ]; then
    $HADOOP_HOME/bin/hdfs namenode -bootstrapStandby
  fi
}

configure $HADOOP_HOME/etc/hadoop/core-site.xml CORE_SITE
configure $HADOOP_HOME/etc/hadoop/hdfs-site.xml HDFS_SITE
configure $HADOOP_HOME/etc/hadoop/mapred-site.xml MAPRED_SITE
configure $HADOOP_HOME/etc/hadoop/yarn-site.xml YARN_SITE

# Arrancar servicio ssh
service ssh start

# Arrancar Hadoop Pseudo-distribuido
if [ "${HADOOP_PSEUDO_MODE}" == "1" ]; then
  echo "localhost" > $HADOOP_HOME/etc/hadoop/workers
  check_hdfs_format
  $HADOOP_HOME/bin/hdfs --daemon start namenode
  $HADOOP_HOME/bin/hdfs --daemon start datanode
  $HADOOP_HOME/bin/hdfs --daemon start secondarynamenode
  $HADOOP_HOME/bin/yarn --daemon start resourcemanager
  $HADOOP_HOME/bin/yarn --daemon start nodemanager
  $HADOOP_HOME/bin/mapred --daemon start historyserver
  sleep 1
fi

# Arrancar Hadoop Distribuido
# Nodos nn para High Availability
if [[ "${HADOOP_TYPE}" == "nn1" ]]; then
  check_hdfs_format_ha
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/hdfs --daemon start namenode
  printf "namenode started\n"
  hdfs --daemon start zkfc
  printf "zkfc started\n"
  jps
  sleep 1
fi
if [[ "${HADOOP_TYPE}" == "nn2" ]]; then
  check_hdfs_bootstrapStandby
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/hdfs --daemon start namenode
  printf "namenode started\n"
  hdfs --daemon start zkfc
  printf "zkfc started\n"
  jps
  sleep 1
fi
if [[ "${HADOOP_TYPE}" == "nn3" ]]; then
  check_hdfs_bootstrapStandby
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/hdfs --daemon start namenode
  printf "namenode started\n"
  hdfs --daemon start zkfc
  printf "zkfc started\n"
  jps
  sleep 1
fi

# Arrancar Hadoop Distribuido nodos
if [[ "${HADOOP_TYPE}" == *"namenode"* ]]; then
  check_hdfs_format
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/hdfs --daemon start namenode
  printf "namenode started\n"
  jps
  sleep 1
fi
if [[ "${HADOOP_TYPE}" == *"datanode"* ]]; then
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/hdfs --daemon start datanode
  printf "datanode started\n"
  jps
  sleep 1
fi
if [[ "${HADOOP_TYPE}" == *"secondarynamenode"* ]]; then
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/hdfs --daemon start secondarynamenode
  printf "secondarynamenode started\n"
  jps
  sleep 1
fi
if [[ "${HADOOP_TYPE}" == *"journalnode"* ]]; then
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/hdfs --daemon start journalnode
  printf "journalnode started\n"
  jps
  sleep 1
fi


# Yarn
if [[ "${HADOOP_TYPE}" == *"resourcemanager"* ]]; then
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/yarn --daemon start resourcemanager
  printf "resourcemanager started\n"
  jps
  sleep 1
fi
if [[ "${HADOOP_TYPE}" == *"nodemanager"* ]]; then
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/yarn --daemon start nodemanager
  printf "nodemanager started\n"
  jps
  sleep 1
fi
if [[ "${HADOOP_TYPE}" == *"historyserver"* ]]; then
  printf "Hello %s\n" "$(hostname)"
  $HADOOP_HOME/bin/mapred --daemon start historyserver
  printf "historyserver started\n"
  jps
  sleep 1
fi

# Mantener el contenedor ejecutandose
tail -f /dev/null