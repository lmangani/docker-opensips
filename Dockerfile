FROM ubuntu:14.04
MAINTAINER bokai

RUN apt-get update
RUN echo "mysql-server mysql-server/root_password password passwd" | sudo debconf-set-selections && \
    echo "mysql-server mysql-server/root_password_again password passwd" | sudo debconf-set-selections && \
    apt-get install -y mysql-server

RUN apt-get install -y vim git make bison flex libmysqlclient-dev libncurses5 libncurses5-dev mysql-client

RUN cd ~ && \
    git clone https://github.com/OpenSIPS/opensips.git -b 2.1 opensips_2_1

RUN sed -i 's/db_http db_mysql db_oracle/db_http db_oracle/g' ~/opensips_2_1/Makefile.conf.template

RUN cd ~/opensips_2_1 && make all && make install

RUN sed -i -e 's/# SIP_DOMAIN/SIP_DOMAIN=ubuntustudio /i'  /usr/local/etc/opensips/opensipsctlrc
RUN sed -i -e 's/# DBENGINE=MYSQL/DBENGINE=MYSQL /i'  /usr/local/etc/opensips/opensipsctlrc
RUN sed -i -e 's/# DBHOST=localhost/DBHOST=localhost /i'  /usr/local/etc/opensips/opensipsctlrc
RUN sed -i -e 's/# DBNAME=opensips/DBNAME=opensips /i'  /usr/local/etc/opensips/opensipsctlrc
RUN sed -i -e 's/# DBRWUSER=opensips/DBRWUSER=opensips /i'  /usr/local/etc/opensips/opensipsctlrc
RUN sed -i -e 's/# DBRWPW="opensipsrw"/DBRWPW="opensipsrw" /i'  /usr/local/etc/opensips/opensipsctlrc
RUN sed -i -e 's/# DBROOTUSER="root"/DBROOTUSER="root" /i'  /usr/local/etc/opensips/opensipsctlrc
RUN sed -i -e 's/# USERCOL="username"/USERCOL="username /i'  /usr/local/etc/opensips/opensipsctlrc
RUN sed -i -e 's/# DB_PATH/DB_PATH /i'  /usr/local/etc/opensips/opensipsctlrc

RUN chmod 777 /var
RUN chmod 777 /var/run
RUN chmod 755 /usr/local/etc/opensips/opensips.cfg

COPY run.sh /etc/run.sh
RUN chown root.root /etc/run.sh
RUN chmod 700 /etc/run.sh

ENTRYPOINT ["/etc/run.sh"]
