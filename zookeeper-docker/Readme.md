# :man_farmer: Creación de ambiente zookeeper en docker

Imagen de zookeeper lista para utilizar.

Dos modos:

* simple
* cluster

Zookeeper se encuentra instalado en:

* ZOOKEEPER_HOME=/opt/zookeeper

Se utiliza JAVA 8 instalado en:

* JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

## :zap: Modo simple

Para el modo simple solo hay que utilizar las variable:

* HADOOP_TYPE=zookeeper
* myid=1

Se lanzan los siguientes servicios en un solo contenedor:

* QuorumPeerMain

Se encuentra el docker-compose listo en la carpeta:

* launch-zookeeper-single

## :rocket: Modo cluster

Para el modo cluster completo solo hay que utilizar la variable:

* HADOOP_TYPE=zookeeper
* myid=1

Hay que configurar la variable **myid** con el numero del nodo del cluster

Se encuentra el docker-compose listo en la carpeta:

* launch-zookeeper-cluster

Se lanzan 3 contenedores con:

* QuorumPeerMain

## :wrench: Configuración de variables externas

Los archivos de zookeeper se configuran mediante variables externas, las cuales son leidas al lanzar el contenedor y se regeneran los archivos.  
Archivo parametrizable:

* zoo.cfg

Estos archivos fisicamente se encuentran en la carpeta:

```bash
$ZOOKEEPER_HOME/conf/
```

Prefijos de las variables:

* ZOO: para el archivo zoo.cfg

Por ejemplo para setear la siguiente configuración en el archivo zoo.cfg se debe crear al siguiente variable:

```xml
clientPort=2181
```

Variable nueva:

```dockerfile
ZOO_clientPort=2181
```

Más info en el archivo **zoo.env**

## :package: Repositorio

Github: [https://github.com/ezeparziale/big-data-cluster](https://github.com/ezeparziale/big-data-cluster)
