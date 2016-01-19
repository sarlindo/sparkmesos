FROM mesosphere/mesos:0.26.0-0.2.145.ubuntu1404

MAINTAINER Arlindo Santos <sarlindo@hotmail.com>

# Update the base ubuntu image with dependencies needed for Spark
RUN apt-get install -y python libnss3 curl

# Spark dependencies
ENV APACHE_SPARK_VERSION 1.6.0
RUN apt-get -y update && \
    apt-get install -y --no-install-recommends openjdk-7-jre-headless && \
    apt-get clean

RUN mkdir /opt/spark && \
    curl http://apache.mirror.rafal.ca/spark/spark-1.6.0/spark-1.6.0-bin-hadoop2.6.tgz \
    | tar --strip-components=1 -xzC /opt/spark && \
    rm /opt/spark/lib/spark-examples-*.jar

ENV SPARK_HOME /opt/spark
ENV PATH $PATH:/opt/spark/bin
ENV MESOS_NATIVE_JAVA_LIBRARY /usr/local/lib/libmesos.so
