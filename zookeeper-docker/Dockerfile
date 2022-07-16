# Seteo de imagen a utilizar, ubuntu 20.04
FROM ezeparziale/hadoop-docker:1.1.0-hadoop3.3.3-ubuntu-java8

# Seteo de variables globales
ENV ZOOKEEPER_HOME=/opt/zookeeper
ENV ZOOKEEPER_DATA=/zookeeper-data
ENV PATH=$PATH:$ZOOKEEPER_HOME/bin:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

# Descargar Zookeeper 3.8.0
ENV ZOOK_VERSION=3.8.0
# COPY ./binary/* .
RUN wget "https://dlcdn.apache.org/zookeeper/zookeeper-$ZOOK_VERSION/apache-zookeeper-$ZOOK_VERSION-bin.tar.gz" && \
    tar xzf apache-zookeeper-$ZOOK_VERSION-bin.tar.gz && \
    mv apache-zookeeper-$ZOOK_VERSION-bin $ZOOKEEPER_HOME && \
    rm apache-zookeeper-$ZOOK_VERSION-bin.tar.gz && \
    mkdir $ZOOKEEPER_DATA

# Copiado de archivos de configuración
COPY config/zookeeper/conf/* $ZOOKEEPER_HOME/conf/
COPY config/*-zoo.sh .

ENTRYPOINT [ "./start-zoo.sh" ]