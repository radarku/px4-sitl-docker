#!/bin/bash
HOST_IP=$1
socat UDP4-RECVFROM:14550,fork UDP4-SENDTO:${HOST_IP}:14550 &
HEADLESS=1 make px4_sitl_default gazebo
