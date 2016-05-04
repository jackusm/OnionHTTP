FROM debian:jessie
MAINTAINER jackusm, https://github.com/jackusm

RUN apt-get update && apt-get -y install nginx vim tor supervisor cron
ADD ./conf/supervise-ngircd.conf /etc/supervisor/conf.d/supervise-ngircd.conf
ADD ./conf/supervise-tor.conf /etc/supervisor/conf.d/supervise-tor.conf
ADD ./conf/rsyslog.conf /etc/rsyslog.conf
ADD ./conf/hidden_service.conf /etc/nginx/sites-available/hidden_service
ADD ./conf/hidden_service.conf /etc/nginx/sites-enabled/hidden_service
ADD ./conf/torrc /etc/tor/torrc
ADD ./conf/crontab /etc/cron.d/database
CMD ["/usr/bin/supervisord", "-n"]