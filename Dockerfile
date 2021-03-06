FROM ubuntu:bionic

WORKDIR /ardupilot

RUN DEBIAN_FRONTEND=noninteractive apt update && apt install -y git sudo

COPY setup-tz.sh /
RUN /bin/bash /setup-tz.sh

RUN useradd -U -d /ardupilot ardupilot && usermod -G users ardupilot && chown ardupilot:users /ardupilot && echo "ardupilot ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ardupilot && chmod 0440 /etc/sudoers.d/ardupilot

USER ardupilot
RUN git clone https://github.com/ArduPilot/ardupilot . && git checkout -b ArduPlane-4.0.5 ArduPlane-4.0.5 && git submodule update --init --recursive

ENV USER=ardupilot
RUN DEBIAN_FRONTEND=noninteractive Tools/environment_install/install-prereqs-ubuntu.sh -y

ENV PATH /usr/lib/ccache:/ardupilot/Tools:${PATH}
ENV PATH /ardupilot/Tools/autotest:${PATH}
ENV PATH /ardupilot/.local/bin:$PATH
