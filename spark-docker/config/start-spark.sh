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

configure $HADOOP_HOME/etc/hadoop/core-site.xml CORE_SITE
configure $HADOOP_HOME/etc/hadoop/hdfs-site.xml HDFS_SITE
configure $HADOOP_HOME/etc/hadoop/mapred-site.xml MAPRED_SITE
configure $HADOOP_HOME/etc/hadoop/yarn-site.xml YARN_SITE


# Arrancar servicio ssh
service ssh start

# Arrancar Spark Distribuido
# Spark
if [ "${SPARK_TYPE}" == "master" ]; then
  printf "Hello %s\n" "$(hostname)"
  $SPARK_HOME/sbin/start-master.sh
  printf "marter spark started\n"
  jps
  sleep 1
fi
if [ "${SPARK_TYPE}" == "worker" ]; then
  printf "Hello %s\n" "$(hostname)"
  $SPARK_HOME/sbin/start-worker.sh $SPARK_MASTER
  printf "worker spark started\n"
  jps
  sleep 1
fi

# Mantener el contenedor ejecutandose
tail -f /dev/null