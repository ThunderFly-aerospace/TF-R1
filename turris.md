# Turris mox/omnia

## LXR
### Nastavení LXC kontejneru a USB

v OpenWRT je potřeba nainstalovat `kmod-usb-serial-ftdi`. 

```
opkg update; opkg install kmod-usb-serial-ftdi
```
Pak je potřeba zjistit, jestli se USB v dmesg připojí a dostane nějaký tty soubor v pořádku nebo ne. Pokud ano, lze pokračovat. 

Následně se USB musí nastavit v konfiguraci kontejneru. 
```
# Template used to create this container: /usr/share/lxc/templates/lxc-download
# Parameters passed to the template: --dist Ubuntu --release Focal --arch armv7l --server repo.turris.cz/lxc --no-validate
# For additional config options, please look at lxc.container.conf(5)

# Uncomment the following line to support nesting containers:
#lxc.include = /usr/share/lxc/config/nesting.conf
# (Be aware this has security implications)

# Some workarounds
# Template to generate fixed MAC address

# Distribution configuration
lxc.arch = armv7l

# Container specific configuration
lxc.include = /usr/share/lxc/config/common.conf
lxc.hook.start-host = /usr/share/lxc/hooks/systemd-workaround
lxc.rootfs.path = btrfs:/srv/lxc/TF-R2_server/rootfs
lxc.uts.name = TF-R2_server

# Network configuration
lxc.net.0.type = veth
lxc.net.0.link = br-lan
lxc.net.0.flags = up
lxc.net.0.name = eth0
lxc.net.0.hwaddr = a2:e2:d9:8b:64:11

lxc.mount.entry = /dev/bus/usb dev/bus/usb none bind,optional,create=dir 0 0
lxc.cgroup.devices.allow = c 188:0 rwm

# lxc.group.devices.allow = c 166:* rwm
# lxc.mount.entry = /dev/ttyACM0 dev/ttyACM0  none bind,optional,create=file 0 0
# lxc.mount.entry = /dev/ttyACM1 dev/ttyACM1  none bind,optional,create=file 0 0
# lxc.mount.entry = /dev/ttyACM2 dev/ttyACM2  none bind,optional,create=file 0 0

lxc.mount.entry = /dev/ttyUSB0 dev/ttyUSB0  none bind,optional,create=file,umask=000 0 0
# lxc.mount.entry = /dev/ttyUSB1 dev/ttyUSB1  none bind,optional,create=file 0 0
# lxc.mount.entry = /dev/ttyUSB2 dev/ttyUSB2  none bind,optional,create=file 0 0
```


### Turris MOX (specifika)

> 2021/05
Při použití [USB modulu (MOX-F)](https://doc.turris.cz/doc/cs/howto/mox/mox-f-usb) je potřeba po jeho prvním zapojení nastavit toto: 
```
fw_setenv quirks pci=nomsi
```

Jinak se děje, že USB hub se neustále odpojuje. (předpokládá se, že systém je aktuální)
