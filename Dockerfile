FROM tomcat:8.5.37-jre8-alpine
RUN apk add -q --update --no-cache bash &&\
    rm -rf /var/cache/apk/ &&\
    rm -rf /tmp/*

COPY app/%%APP_NAME%%*.war /usr/local/tomcat/webapps/%%APP_NAME%%.war
COPY app-config/%%APP_PROP%%.properties /usr/local/tomcat/lib/%%APP_NAME%%.properties

COPY docker-config/setenv.sh /usr/local/tomcat/bin/setenv.sh
RUN chmod ugo+x /usr/local/tomcat/bin/setenv.sh

ADD ./run /usr/local/bin/run
VOLUME ["/usr/local/tomcat/webapps"]
VOLUME ["/usr/local/tomcat/logs"]
CMD ["/usr/local/bin/run"]
CMD ["catalina.sh", "run"]