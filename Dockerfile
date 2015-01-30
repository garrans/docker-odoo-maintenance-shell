#
# Dockerfile for Odoo-Maintenance Shell
#
# Based on instructions from https://github.com/ether/etherpad-lite
#
FROM ubuntu:latest
MAINTAINER Stephen Garran <stephen@insoproco.com>

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

VOLUME  ["/var/lib/odoo"]

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

