FROM ubuntu:bionic

WORKDIR /ardupilot

RUN DEBIAN_FRONTEND=noninteractive apt update && apt install -y git sudo gdb

COPY setup-tz.sh /
RUN /bin/bash /setup-tz.sh

RUN useradd -U -d /ardupilot ardupilot && usermod -G users ardupilot && chown ardupilot:users /ardupilot && echo "ardupilot ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ardupilot && chmod 0440 /etc/sudoers.d/ardupilot

USER ardupilot
RUN git clone https://github.com/ArduPilot/ardupilot . && git checkout -b Rover-4.0.0 Rover-4.0.0 && git submodule update --init --recursive

#COPY *.patch .
#RUN for p in `ls *.patch`; do echo "Applying $p"; patch -p1 < $p; done

ENV USER=ardupilot
RUN DEBIAN_FRONTEND=noninteractive Tools/environment_install/install-prereqs-ubuntu.sh -y

ENV PATH /usr/lib/ccache:/ardupilot/Tools/scripts:${PATH}
ENV PATH /ardupilot/Tools/autotest:${PATH}
ENV PATH /ardupilot/.local/bin:$PATH
