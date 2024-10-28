FROM ubuntu:jammy

WORKDIR /ardupilot

ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y git sudo gdb

COPY setup-tz.sh /
RUN /bin/bash /setup-tz.sh

RUN useradd -U -d /ardupilot ardupilot && usermod -G users ardupilot && chown ardupilot:users /ardupilot && echo "ardupilot ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ardupilot && chmod 0440 /etc/sudoers.d/ardupilot

# VEHICLE_TYPE selects the build type to build (values: Plane,Copter,ArduSub,Rover)
ARG VEHICLE_TYPE=Plane
# ARDUPILOT_VERSION selects which version to build
ARG ARDUPILOT_VERSION

COPY fetch.sh /
USER ardupilot
RUN /fetch.sh $VEHICLE_TYPE $ARDUPILOT_VERSION

ENV USER ardupilot
RUN SKIP_AP_GRAPHIC_ENV=1 DEBIAN_FRONTEND=noninteractive Tools/environment_install/install-prereqs-ubuntu.sh -y

ENV PATH /usr/lib/ccache:/ardupilot/Tools/scripts:${PATH}
ENV PATH /ardupilot/Tools/autotest:${PATH}
ENV PATH /ardupilot/.local/bin:$PATH
