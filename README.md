
PX4 Software In-the-Loop Simulator
==================================

The purpose is to have a docker-isolated PX4 SITL via gazebo.

Building and Running
--------------------

To build:

```
docker build --rm --tag px4-sitl .
```

To run:

```
docker run --rm -it -p5760:5760 --env HOST_IP=192.168.1.122 px4-sitl
```

...which starts a MAVLink TCP socket listening at port 5760 and pushes a UDP video stream to HOST_IP:5600

Settings
--------
```
--env PX4_HOME_LAT   42.3898
--env PX4_HOME_LON   -71.1476
--env PX4_HOME_ALT   14.2
```

Usage
-----

You should get an interactive PX4 shell, which you can use:
```
pxh> commander takeoff
```

Alternatively you can connect to the MAVLink stream:
```
mavproxy.py --master=tcp:127.0.0.1:5760
```

If you start getting this RC FAILSAFE:
```
INFO  [commander] Takeoff detected
WARN  [commander] Failsafe enabled: no datalink
INFO  [navigator] RTL HOME activated
INFO  [navigator] RTL: climb to 25 m (11 m above home)
INFO  [navigator] RTL: return at 25 m (11 m above home)
INFO  [navigator] RTL: land at home
```

Go into your GCS and update the parameter `NAV_RCL_ACT` (Set RC loss failsafe mode) to `0` (Disabled) as explained here:

https://docs.px4.io/en/advanced_config/parameter_reference.html#NAV_RCL_ACT


