


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

