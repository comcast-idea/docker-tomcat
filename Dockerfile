FROM smatochkin/java:oracle8

MAINTAINER Sergey Matochkin <sergey@matochkin.com>

ENV TOMCAT_MAJOR_VERSION 8
ENV TOMCAT_MINOR_VERSION 8.0.11
ENV CATALINA_HOME /tomcat

# INSTALL TOMCAT
RUN curl -OL https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
    curl -L https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
    tar zxf apache-tomcat-*.tar.gz && \
    rm apache-tomcat-*.tar.gz && \
    mv apache-tomcat* $CATALINA_HOME

# Remove management and demo applications
RUN rm -rf $CATALINA_HOME/webapps/*

ADD run.sh /run.sh
RUN chmod +x /*.sh
EXPOSE 8080

CMD ["/tomcat/bin/catalina.sh", "run"]
