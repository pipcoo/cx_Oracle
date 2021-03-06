#Version 1.0.0
FROM python:3.7.4-slim
MAINTAINER pipcoo <blcat@hotmail.com>

RUN set -x &&\
	# echo "deb http://mirrors.aliyun.com/debian/ buster main non-free contrib" > /etc/apt/sources.list &&\
	# echo "deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib" >> /etc/apt/sources.list &&\
	# echo "deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib" >> /etc/apt/sources.list &&\
	# echo "deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib" >> /etc/apt/sources.list &&\
	# echo "deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib" >> /etc/apt/sources.list &&\
	# echo "deb http://mirrors.aliyun.com/debian-security/ buster/updates main non-free contrib" >> /etc/apt/sources.list &&\
	# echo "deb-src http://mirrors.aliyun.com/debian-security/ buster/updates main non-free contrib" >> /etc/apt/sources.list &&\
    apt-get update &&\
    apt-get install -y alien wget libaio1 libtiff5-dev \
	zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev  \
	python-tk python-dev openssl libssl-dev libldap2-dev libsasl2-dev \
	sqlite libkrb5-dev sshpass && \
	wget -P /tmp/ https://oss-us-w.oss-us-west-1.aliyuncs.com/software/oracle_client/oracle-instantclient12.2-basiclite-12.2.0.1.0-1.x86_64.rpm &&\
	wget -P /tmp/ https://oss-us-w.oss-us-west-1.aliyuncs.com/software/oracle_client/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm &&\
	alien -iv /tmp/oracle-instantclient12.2-basiclite-12.2.0.1.0-1.x86_64.rpm &&\
	alien -iv /tmp/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm &&\
	pip3 install cx_Oracle &&\
	apt-get purge -y alien perl perl5 wget && apt-get -y autoremove && apt-get clean && \
    rm -rf /tmp/oracle-* && rm -rf /usr/share/docs && rm -rf /usr/share/man 

# Environment variables
ENV ORACLE_HOME=/usr/lib/oracle/12.2/client64
ENV LD_LIBRARY_PATH=$ORACLE_HOME/lib
ENV PATH=$ORACLE_HOME/bin:$PATH

CMD ["/bin/bash"]
