FROM ubuntu:bionic
ENV container docker
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y install gnupg curl && \
    curl -sL https://deb.nodesource.com/setup_12.x  | bash - && \
    apt-get install -y nodejs xvfb dbus-x11 firefox libxtst-dev \
    x11-apps xserver-xorg-core x11-xserver-utils wget x11vnc jwm git

RUN mkdir -p /var/lib/dbus &&\
    mkdir /var/run/dbus && \
    dbus-uuidgen > /var/lib/dbus/machine-id

    
RUN useradd chimera && \
    mkdir -p /home/chimera && \
    chown chimera:chimera /home/chimera

USER chimera

WORKDIR /home/chimera
COPY --chown=chimera:chimera noVNC noVNC
COPY --chown=chimera:chimera server server

RUN chmod +x server/scripts/windowresize.sh
RUN chmod +x server/scripts/run.sh
RUN chmod +x server/scripts/user-run.sh

RUN cd server && npm install

USER root

EXPOSE 6080
EXPOSE 6081
EXPOSE 5900
CMD ["server/scripts/run.sh"]