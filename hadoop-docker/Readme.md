# Creación de ambiente hadoop en docker

Imagen docker con hadoop listo para usarse en docker.  
100% personalizable con las variables de entornos.  

Dos modos:
* Pseudo-distribuido
* Distribuido completo

Hadoop se encuentra instalado en:
* HADOOP_HOME=/opt/hadoop

Se utiliza JAVA 8 instalado en:
* JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

&nbsp;

## Modo pseudo-distribuido

Para el modo pseudo-distribuido solo hay que utilizar la variable:
* HADOOP_PSEUDO_MODE=1

Se lanzan los siguientes servicios en un solo contenedor:
* namenode
* datanode
* secondarynamenode
* nodemanager
* resourcemanager
* historyserver

Se encuentra el docker-compose listo en la carpeta:
* launch-pseudo-distributed

&nbsp;

## Modo distribuido completo

Para el modo distribuido completo solo hay que utilizar la variable:
* HADOOP_TYPE = (namenode | datanode | secondarynamenode | nodemanager | resourcemanager | historyserver)

Se pueden lanzar los servicios individuales o en conjunto segun su uso.  
Por ejemplo:
```
HADOOP_TYPE = namenome,resourcemanager,historyserver
```


Se encuentra el docker-compose listo en la carpeta:
* launch-fully-distributed

Se lanzan los siguientes servicios individuales en contenedores separados:
* namenode x1
* datanode x2
* secondarynamenode x1
* nodemanager x2
* resourcemanager x1
* historyserver x1

&nbsp;

## Configuración de variables externas
Los archivos de hadoop se configuran mediante variables externas, las cuales son leidas al lanzar el contenedor y se regeneran los archivos.  
Archivos parametrizables:
* core-site.xml
* hdfs-site.xml
* mapred-site.xml
* yarn-site.xml

Estos archivos fisicamente se encuentran en la carpeta:
```
${HADOOP_HOME}/etc/hadoop
```
Prefijos de las variables:
* CORE_SITE: para el archivo core-site.xml
* HDFS_SITE: para el archivo hdfs-site.xml
* MAPRED_SITE: para el archivo mapred-site.xml
* YARN_SITE: para el archivo yarn-site.xml

Por ejemplo para setear la siguiente configuración en el archivo core-site.xml se debe crear al siguiente variable:


```
<configuration>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://hadoop-master:9000</value>
  </property>
</configuration>
```

Variable nueva:
```
CORE_SITE_fs_defaultFS=hdfs://hadoop-master:9000
```

Más info en el archivo **hadoop.env**

&nbsp;

## Puertos

* 9000: hdfs
* 9870: name node
* 9868: secondary name node
* 19888: history server
* 8088: resource manager

&nbsp;

## Acceso

hdfs:
```
http://localhost:9000
```

name node:
```
http://localhost:9870
```

secondary name node:
```
http://localhost:9868
```

history server:
```
http://localhost:19888
```

resource manager:
```
http://localhost:8088
```

&nbsp;

## Versiones de imagenes

La imagen esta creada sobre Ubuntu 20.04

&nbsp;

## To Do
* Version con high availability