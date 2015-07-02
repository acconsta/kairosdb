# Oracle JDK8 on top of ubuntu
FROM n3ziniuka5/ubuntu-oracle-jdk:14.04-JDK8

MAINTAINER acconsta

# Install KAIROSDB
ADD https://github.com/kairosdb/kairosdb/releases/download/v1.0.0/kairosdb_1.0.0-1_all.deb .
RUN dpkg -i kairosdb_1.0.0-1_all.deb 

ADD logback.xml /opt/kairosdb/conf/logging/logback.xml
ADD kairosdb.properties /opt/kairosdb/conf/kairosdb.properties

# Kairos API telnet and jetty ports
EXPOSE 4242 8083

# Set Kairos config vars
ENV KAIROS_JETTY_PORT 8083
ENV CASSANDRA_HOST_LIST localhost:9042
ENV LOGLEVEL INFO

# Copy scripts into container to set kairos config params
# ADD config-kairos.sh /usr/bin/config-kairos.sh

# Run kairosdb in foreground on boot
CMD ["/opt/kairosdb/bin/kairosdb.sh"]
