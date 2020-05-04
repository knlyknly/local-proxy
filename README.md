# local-proxy

This is the v2ray proxy in-gfw-side configuration I used on my AM3359 board.
It's not quite complete actually. Just runnable.

If you are on a ARM64/x86/AMD64 CPU you have to replace the executables in `v2ray-linux-arm/bin`.
See the releases of [V2Ray](https://github.com/v2ray/v2ray-core/releases).

The out-gfw-side is demanded to be installed as HTTPS+WS+V2RAY, else you need to change 
the `v2ray-linux/arm/etc/config.json.template` file, or even `config.sh` file.

## how to install and start

```
make config
make install
make start
```

The `make config` will prompt for host/port/uuid/altid as your server configured.
The `make install` will copy v2ray executables and configurations into the system and create a service named as 'v2ray'.
The `make start` will run the v2ray service.

## how to uninstall

```
make uninstall
```

Everything installed will be removed.

## The project structure

### v2ray-linux-arm

The release of V2Ray for arm32 which is the platform I'm using besides my WiFi router.
If you're using ARM64/x86/AMD64 arch you can exchange the binary files for right platform.

### gfwlist

This part is actually not completed. I have not yet build the go compile env on ARM32. 
So actually I'm using the [h2y.dat](https://github.com/ToutyRater/V2Ray-SiteDAT/blob/master/geofiles/h2y.dat).

### sedurl

Well... Just a RegExp template to extract hostname from URL...
