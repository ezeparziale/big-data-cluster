# Seteo de imagen a utilizar, ubuntu 20.04
FROM ezeparziale/hadoop-docker:1.1.0-hadoop3.3.1-ubuntu-java8

# Seteo de variables globales
ENV HIVE_HOME=/opt/hive
ENV PATH=$PATH:$HIVE_HOME/bin:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

# Descargar Hive 3.1.2
ENV HIVE_VERSION=3.1.2
# COPY ./binary/* .
RUN wget "https://apache.zero.com.ar/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz" && \
    tar xzf apache-hive-$HIVE_VERSION-bin.tar.gz && \
    mv apache-hive-$HIVE_VERSION-bin $HIVE_HOME && \
    rm apache-hive-$HIVE_VERSION-bin.tar.gz && \
    rm $HADOOP_HOME/share/hadoop/common/lib/slf4j-log4j12-1.7.30.jar && \
    rm *-hadoop.sh

# Copiado de archivos de configuración
COPY config/hive/* $HIVE_HOME/conf/
COPY config/start-hive.sh .
COPY config/lib/* $HIVE_HOME/lib/

ENTRYPOINT [ "./start-hive.sh" ]