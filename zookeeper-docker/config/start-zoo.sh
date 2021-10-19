#!/bin/bash

# Configuración de archivo config de zookeeper en función de las variables de entorno
function addProperty() {
  local path=$1
  local name=$2
  local value=$3

  echo "$name=${value}" >> $path
}

function configure() {
    local path=$1
    local envPrefix=$2

    local var
    local value
    
    echo "Configurando: ${envPrefix,,}.cfg"
    for c in `printenv | perl -sne 'print "$1 " if m/^${envPrefix}_(.+?)=.*/' -- -envPrefix=$envPrefix`; do 
        name=`echo ${c} | perl -pe 's/_____/:/g; s/____/_/g; s/___/-/g; s/__/@/g; s/_/./g;'`
        var="${envPrefix}_${c}"
        value=${!var}
        echo " - Setting $name=$value"
        addProperty $path $name "$value"
    done
}

configure $ZOOKEEPER_HOME/conf/zoo.cfg ZOO

# Arrancar servicio ssh
service ssh start

# Arrancar Zookeeper server
if [ "${HADOOP_TYPE}" == "zookeeper" ]; then
  printf "Hello %s\n" "$(hostname)"
  echo $myid > /zookeeper-data/myid
  zkServer.sh start
  printf "zkServer started\n"
  sleep 1
fi

# Mantener el contenedor ejecutandose
tail -f /dev/null