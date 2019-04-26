FROM ubuntu:16.04
LABEL maintainer Kyle Usbeck

# Need Git to checkout our sources
RUN apt-get update && apt-get install -y git

# Download PX4 requirements
# Trick to get apt-get to not prompt for timezone in tzdata
ENV DEBIAN_FRONTEND=noninteractive

# Need sudo and lsb-release for the installation prerequisites
RUN apt-get install -y sudo lsb-release tzdata wget
RUN wget https://raw.githubusercontent.com/PX4/Devguide/master/build_scripts/ubuntu_sim_common_deps.sh
RUN chmod +x ubuntu_sim_common_deps.sh
RUN ./ubuntu_sim_common_deps.sh

# Now grab ArduPilot from GitHub
#RUN git clone https://kusbeck@collab.bbn.com/bitbucket/scm/suas/lumenier-px4.git lumenier-px4
RUN git clone https://github.com/PX4/Firmware.git lumenier-px4
WORKDIR lumenier-px4

# Checkout the right repo
#RUN git checkout lumenier-dev

# Now start build instructions from https://dev.px4.io/en/setup/building_px4.html
RUN make posix

RUN apt-get install -y mesa-utils

# Start JMavSim
ENTRYPOINT JAVA_OPTS="--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.invoke=ALL-UNNAMED" make posix jmavsim

## Trick to get apt-get to not prompt for timezone in tzdata
#ENV DEBIAN_FRONTEND=noninteractive
#
## Need sudo and lsb-release for the installation prerequisites
#RUN apt-get install -y sudo lsb-release tzdata
#
## Need USER set so usermod does not fail...
## Install all prerequisites now
#RUN USER=nobody Tools/scripts/install-prereqs-ubuntu.sh -y
#
## Continue build instructions from https://github.com/ArduPilot/ardupilot/blob/master/BUILD.md
#RUN ./waf distclean
#RUN ./waf configure --board sitl
#RUN ./waf copter
#RUN ./waf rover 
#RUN ./waf plane
#RUN ./waf sub
#
## TCP 5760 is what the sim exposes by default
#EXPOSE 5760/tcp
#
## Variables for simulator
#ENV INSTANCE 0
#ENV LAT 42.3898
#ENV LON -71.1476
#ENV ALT 14
#ENV DIR 270
#ENV MODEL +
#ENV SPEEDUP 1
#ENV VEHICLE ArduCopter
#
## Finally the command
#ENTRYPOINT /ardupilot/Tools/autotest/sim_vehicle.py --vehicle ${VEHICLE} -I${INSTANCE} --custom-location=${LAT},${LON},${ALT},${DIR} -w --frame ${MODEL} --no-rebuild --no-mavproxy --speedup ${SPEEDUP}
