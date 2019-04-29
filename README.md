
PX4 Software In-the-Loop Simulator
==================================

The purpose is to have a docker-isolated PX4 SITL via gazebo.

Usage
-----

To build:

```
docker build --rm --tag lumenier .
```

To run:

```
docker run --rm -it --env HOST_IP 192.168.1.113 lumenier
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


Forwarding X11
--------------

First:

Setup X11 to "Allow connections from network clients"

via instructions from

https://cntnr.io/running-guis-with-docker-on-mac-os-x-a14df6a76efc

Next:

```
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
```

Then:

```
docker run -e DISPLAY=192.168.1.235:0 gns3/xeyes
```

...where 192.168.1.235 is your host IP addr

You may need the `--privileged` flag for some interaction paradigms with X.

