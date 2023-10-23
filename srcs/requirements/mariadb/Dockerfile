FROM debian:bullseye

RUN apt-get update && \
    apt-get install \
    -y mariadb-server mariadb-client netcat

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 755 /var/run/mysqld
COPY	./conf/setup.conf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY	./conf/setup.sh /usr/local/bin/setup.sh
RUN	chmod 755 /usr/local/bin/setup.sh

EXPOSE 3306

CMD ["/usr/local/bin/setup.sh"]