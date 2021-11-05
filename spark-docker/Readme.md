# Apache Spark Cluster

Imagen docker con spark listo para usarse en docker.  
100% personalizable con las variables de entornos.  

## Modo standard

Se lanzan los siguientes servicios en un solo contenedor:

* master x1
* worker x2

Se encuentra el docker-compose listo en la carpeta:

* lauch-spark-std

## Acceso

Web UI Standalone Master

```http
http://localhost:8080
```

Web UI Standalone Worker 1

```http
http://localhost:8081
```

Web UI Standalone Worker 2

```http
http://localhost:8082
```

## Puertos

* 8080: web ui master
* 7077: master port
* 8081: worker 1 port
* 8082: worker 2 port

## Configuración de variables externas

Los archivos de hadoop se configuran mediante variables externas, las cuales son leídas al lanzar el contenedor y se regeneran los archivos.  
Archivos parametrizables:

* core-site.xml
* hdfs-site.xml
* mapred-site.xml
* yarn-site.xml

Estos archivos físicamente se encuentran en la carpeta:

```bash
${HADOOP_HOME}/etc/hadoop
```

Prefijos de las variables:

* CORE_SITE: para el archivo core-site.xml
* HDFS_SITE: para el archivo hdfs-site.xml
* MAPRED_SITE: para el archivo mapred-site.xml
* YARN_SITE: para el archivo yarn-site.xml

Por ejemplo, para setear la siguiente configuración en el archivo core-site.xml se debe crear la siguiente variable:

```xml
<configuration>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://hadoop-master:9000</value>
  </property>
</configuration>
```

Variable nueva:

```dockerfile
CORE_SITE_fs_defaultFS=hdfs://hadoop-master:9000
```

Más info en el archivo **hadoop.env**  

Para las variables de configuración de *Spark* se encuentran en el archivo **spark.env**

&nbsp;

## Versiones de imagenes

La imagen esta creada sobre Ubuntu 20.04

## Tags

* 1.0.0-alpha-spark3.1.2-ubuntu-java8
  
  * Version preliminar

* 1.0.0-alpha-spark3.2.0-ubuntu-java8
  
  * Spark 3.2.0 ready

## To Do

* ~~Docker compose~~
* Optimizacion de codigo

&nbsp;

## Repositorio

Github: [https://github.com/ezeparziale/big-data-cluster](https://github.com/ezeparziale/big-data-cluster)