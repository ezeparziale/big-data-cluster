# Seteo de imagen a utilizar, ubuntu 20.04
FROM ubuntu:focal

# Actualizacion e instalación de java8 y shh y python
RUN apt update && apt install -y --no-install-recommends \
    nano \
    wget \
    python3.9 \
    openjdk-8-jdk \
    openssh-server \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Seteo de variables globales
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/sbin:$SPARK_HOME/bin
ENV PYSPARK_PYTHON=python3.9
ENV HADOOP_HOME=/opt/hadoop

# Seteo del directorio de trabajo
WORKDIR /opt

# Descargar Spark 3.3.0
ENV SPARK_VERSION=3.3.0
ENV HADOOP_VERSION=3
RUN wget "https://dlcdn.apache.org/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz" && \
    tar xvzf spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz && \
    mv spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION $SPARK_HOME && \
    rm spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz && \
    mkdir $SPARK_HOME/logs

# Seteo de shh sin clave
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

# Copiado de archivos de configuración
COPY config/conf/* $SPARK_HOME/conf/
COPY config/*-spark.sh .
COPY config/hadoop $HADOOP_HOME/

# Arrancar los servicios para spark
ENTRYPOINT ["./start-spark.sh"]