#!/bin/bash

# Configuración de archivos de hive en función de las variables de entorno
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


function check_metastore_db_format() {
  if [ ! -d "/opt/metastore_db" ] && [ "$HIVE_SITE_hive_metastore_db_type" == "derby" ]; then
    $HIVE_HOME/bin/schematool -dbType $HIVE_SITE_hive_metastore_db_type -initSchema
  fi
}

# Hadoop configuración
configure $HADOOP_HOME/etc/hadoop/core-site.xml CORE_SITE
configure $HADOOP_HOME/etc/hadoop/hdfs-site.xml HDFS_SITE
configure $HADOOP_HOME/etc/hadoop/mapred-site.xml MAPRED_SITE
configure $HADOOP_HOME/etc/hadoop/yarn-site.xml YARN_SITE

# Hive configuración
configure $HIVE_HOME/conf/hive-site.xml HIVE_SITE


# Arrancar Hive
# Derby
if [ "$HIVE_SITE_hive_metastore_db_type" == "derby" ]; then
  check_metastore_db_format
  $HIVE_HOME/bin/hive --service hiveserver2 --hiveconf hive.root.logger=INFO,console
fi

# MySQL
if [ "$HIVE_SITE_hive_metastore_db_type" == "mysql" ] || [ "$HIVE_SITE_hive_metastore_db_type" == "postgres" ]; then
  if [ "$HIVE_MODE" == "hiveserver" ]; then
    $HIVE_HOME/bin/hive --service hiveserver2 --hiveconf hive.root.logger=INFO,console
  fi
  if [ "$HIVE_MODE" == "metastore" ]; then
    $HIVE_HOME/bin/hive --service metastore --hiveconf hive.root.logger=INFO,console
  fi
fi

# Mantener el contenedor ejecutandose
tail -f /dev/null