FROM ubuntu:14.04
MAINTAINER "Kyle Bai <kyle.b@inwinstack.com>"

USER root

RUN apt-get update && \
    echo "mysql-server mysql-server/root_password password passwd" | sudo debconf-set-selections && \
    echo "mysql-server mysql-server/root_password_again password passwd" | sudo debconf-set-selections && \
    apt-get install -y mysql-server git make bison flex libmysqlclient-dev \
                       libncurses5 libncurses5-dev mysql-client expect

RUN git clone https://github.com/OpenSIPS/opensips.git -b 2.2 ~/opensips_2_2 && \
    cd ~/opensips_2_2 && \
    make all include_modules="mysql" && make install include_module="mysql" && \
    cd .. && rm -rf ~/opensips_2_2

RUN apt-get purge -y bison build-essential ca-certificates flex git m4 pkg-config && \
    apt-get autoremove -y && \
    apt-get install -y libmicrohttpd10 && \
    apt-get clean

COPY conf/opensipsctlrc /usr/local/etc/opensips/opensipsctlrc
COPY conf/opensips.cfg /usr/local/etc/opensips/opensips.cfg

COPY boot_run.sh /etc/boot_run.sh
RUN chown root.root /etc/boot_run.sh && chmod 700 /etc/boot_run.sh

EXPOSE 5060/udp

ENTRYPOINT ["/etc/boot_run.sh"]
