# :honeybee: Creación de ambiente hive en docker

Imagen docker con hive listo para usarse en docker.  
100% personalizable con las variables de entornos.

Modos:

* Derby

## :rocket: Modo Derby

utiliza la base de datos derby.

Se encuentra el docker-compose listo en la carpeta:

* launch-hive-derby

Este docker-compose tiene hadoop+hive listo para correr. Ademas tiene las variables configuradas en los archivos **hadoop.env** y **hive.env**.

## :key: Puertos

* 10000: hive
* 10002: hive home

## :link: Acceso

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
!connect -u jdbc:hive2://localhost:10000
```

Loguearse:

```bash
user: root
pass: {{blank<}}
```

## :package: Repositorio

Github: [https://github.com/ezeparziale/big-data-cluster](https://github.com/ezeparziale/big-data-cluster)
