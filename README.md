
PX4 Software In-the-Loop Simulator
==================================

The purpose is to have a docker-isolated PX4 SITL via gazebo.

Usage
-----

To build:

```
docker build --rm --tag px4-sitl .
```

To run:

```
docker run --rm -it --env HOST_IP 192.168.1.113 px4-sitl
```

...which will send MAVLink to UDP 192.168.1.113 at port 14550


Settings:
```
--env PX4_HOME_LAT   42.3898
--env PX4_HOME_LON   -71.1476
--env PX4_HOME_ALT   14.2
--env HOST_IP        192.168.1.113
```

You should get a shell; try typing:
```
pxh> commander takeoff
```

Currently, I'm getting this RC FAILSAFE:
```
INFO  [commander] Takeoff detected
WARN  [commander] Failsafe enabled: no datalink
INFO  [navigator] RTL HOME activated
INFO  [navigator] RTL: climb to 25 m (11 m above home)
INFO  [navigator] RTL: return at 25 m (11 m above home)
INFO  [navigator] RTL: land at home
```
