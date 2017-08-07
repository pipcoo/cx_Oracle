#Version 1.0.0
FROM python:3.5.3-slim
MAINTAINER pipcoo <pipcoo@pipcoo.com>

ADD ./sources.list /etc/apt/sources.list

RUN set -x &&\
    apt-get update &&\
    apt-get install -y alien wget &&\
	wget -P /tmp/ http://cf.touchfound.net/docker-config-file/tools/oracle_client/oracle-instantclient12.2-basiclite-12.2.0.1.0-1.x86_64.rpm &&\
	wget -P /tmp/ http://cf.touchfound.net/docker-config-file/tools/oracle_client/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm &&\
	alien -iv /tmp/docker-config-file/tools/oracle_client/oracle-instantclient12.2-basiclite-12.2.0.1.0-1.x86_64.rpm &&\
	alien -iv /tmp/docker-config-file/tools/oracle_client/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm &&\
	apt-get install -y libaio1 &&\
	pip3 install cx_Oracle &&\
	apt-get purge -y alien perl perl5 wget && apt-get -y autoremove && apt-get clean && \
    rm -rf /tmp/oracle-* && rm -rf /usr/share/docs && rm -rf /usr/share/man 

# Environment variables
ENV ORACLE_HOME=/usr/lib/oracle/12.2/client64
ENV LD_LIBRARY_PATH=$ORACLE_HOME/lib
ENV PATH=$ORACLE_HOME/bin:$PATH

CMD ["/bin/bash"]