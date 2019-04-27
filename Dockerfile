FROM ubuntu:16.04
LABEL maintainer Kyle Usbeck

# Need Git to checkout our sources
RUN apt-get update && apt-get install -y git

# Download PX4 requirements
# Trick to get apt-get to not prompt for timezone in tzdata
ENV DEBIAN_FRONTEND=noninteractive

# Need sudo and lsb-release for the installation prerequisites
RUN apt-get install -y sudo lsb-release tzdata wget
#RUN wget https://raw.githubusercontent.com/PX4/Devguide/master/build_scripts/ubuntu_sim_common_deps.sh
RUN wget https://raw.githubusercontent.com/PX4/Devguide/master/build_scripts/ubuntu_sim.sh
RUN chmod +x ubuntu_sim.sh
RUN ./ubuntu_sim.sh

# Now grab ArduPilot from GitHub
#RUN git clone https://kusbeck@collab.bbn.com/bitbucket/scm/suas/lumenier-px4.git lumenier-px4
RUN git clone https://github.com/PX4/Firmware.git lumenier-px4
WORKDIR lumenier-px4

# Checkout the right branch/tag
#RUN git checkout lumenier-dev

# Now start build instructions from https://dev.px4.io/en/setup/building_px4.html
# just build; don't run; https://github.com/PX4/Firmware/issues/3961
RUN DONT_RUN=1 make px4_sitl_default gazebo

# UDP 14550 is what the sim exposes by default
#https://dev.px4.io/en/simulation/
#EXPOSE 14550/udp

ENV PX4_HOME_LAT 42.3898
ENV PX4_HOME_LON -71.1476
ENV PX4_HOME_ALT 14.2
ENV HOST_IP 192.168.1.113

# Start Sim
RUN apt-get install -y socat
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh ${HOST_IP}

## Variables for simulator
#ENV INSTANCE 0
#ENV DIR 270
#ENV MODEL +
#ENV SPEEDUP 1
#ENV VEHICLE ArduCopter
#
## Finally the command
#ENTRYPOINT /ardupilot/Tools/autotest/sim_vehicle.py --vehicle ${VEHICLE} -I${INSTANCE} --custom-location=${LAT},${LON},${ALT},${DIR} -w --frame ${MODEL} --no-rebuild --no-mavproxy --speedup ${SPEEDUP}
