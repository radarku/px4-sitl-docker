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
RUN git clone https://github.com/PX4/Firmware.git
WORKDIR Firmware

# Checkout the right branch/tag
#RUN git checkout ???

# Now start build instructions from https://dev.px4.io/en/setup/building_px4.html
# just build; don't run; https://github.com/PX4/Firmware/issues/3961
RUN DONT_RUN=1 make px4_sitl_default gazebo

# UDP 14550 is what the sim exposes by default
#https://dev.px4.io/en/simulation/

ENV PX4_HOME_LAT 42.3898
ENV PX4_HOME_LON -71.1476
ENV PX4_HOME_ALT 14.2
ENV HOST_IP 192.168.1.113

# Start Sim
RUN apt-get install -y socat
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh ${HOST_IP}
