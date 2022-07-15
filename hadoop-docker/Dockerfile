# Seteo de imagen a utilizar, ubuntu 20.04
FROM ubuntu:focal

# Actualizacion e instalación de java8 y shh
RUN apt update && apt install -y --no-install-recommends \
    nano \
    wget \
    openjdk-8-jdk \
    openssh-server \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Seteo de variables globales
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_INSTALL=$HADOOP_HOME
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV HADOOP_YARN_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
ENV HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
ENV PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

# Seteo del directorio de trabajo
WORKDIR /opt

# Descargar hadoop 3.3.3
ENV HADOOP_VERSION=3.3.3
RUN wget "https://apache.zero.com.ar/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz" && \
    tar xzf hadoop-$HADOOP_VERSION.tar.gz && \
    mv hadoop-$HADOOP_VERSION $HADOOP_HOME && \
    rm -rf $HADOOP_HOME/share/doc && \
    rm hadoop-$HADOOP_VERSION.tar.gz && \
    mkdir $HADOOP_HOME/logs

# Seteo de shh sin clave
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

# Copiado de archivos de configuración
COPY config/hadoop/etc/hadoop/* $HADOOP_HOME/etc/hadoop/
COPY config/*-hadoop.sh .

# Arrancar los servicios para hadoop
ENTRYPOINT ["./start-hadoop.sh"]