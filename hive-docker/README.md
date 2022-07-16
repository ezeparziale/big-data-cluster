# :honeybee: Creación de ambiente hive en docker

Imagen docker con hive listo para usarse en docker.  
100% personalizable con las variables de entornos.

Modos:

* Derby
* Postgres

## :rocket: Modo Derby

utiliza la base de datos derby.

Se encuentra el docker-compose listo en la carpeta:

* launch-hive-derby

Este docker-compose tiene hadoop+hive listo para correr. Ademas tiene las variables configuradas en los archivos **hadoop.env** y **hive.env**.

## :zap: Modo Postgres

Utiliza la base de datos postgres como metastore

Se encuentra en el docker-compose listo en la carpeta:

* launch-hive-postgres

Este docker-compose tiene hadoop+hive listo para correr. Ademas tiene las variables configuradas en los archivos **hadoop.env** y **hive.env**.

Ademas inicializa la base de datos con el **init.sql** y prepara la metastore.

## :station: Puertos

* 10000: hive
* 10002: hive home

## :globe_with_meridians: Acceso

hive home:

```html
http://localhost:10002
```

## :computer: Conexion

Usando beeline se puede conectarse con los siguientes parametros:

Acceder a beeline:

```bash
beeline
```

Conectarse a hive:

```bash
!connect jdbc:hive2://localhost:10000
```

Loguearse:

```bash
user: root
pass: {{blank_password}}
```

```bash
show tables;
```

## :bookmark: Tags

* 1.0.0-hadoop3.3.1-ubuntu-java8
  * Primera versión  
* 1.1.0-hadoop3.3.3-ubuntu-java8
  * Hive 3.1.3
  
## :package: Repositorio

Github: [https://github.com/ezeparziale/big-data-cluster](https://github.com/ezeparziale/big-data-cluster)
