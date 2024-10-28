#!/bin/bash

VEHICLE_TYPE=$1
ARDUPILOT_VERSION=$2

if [[ "${VEHICLE_TYPE}" == "Sub" ]]
then
	VEHICLE_TYPE="ArduSub"
fi

git clone https://github.com/ArduPilot/ardupilot .
git checkout -b ${VEHICLE_TYPE}-${ARDUPILOT_VERSION} ${VEHICLE_TYPE}-${ARDUPILOT_VERSION}
git submodule update --init --recursive

