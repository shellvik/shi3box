## shi3box

- Configs for i3, nvim, tmux and general stuff for ctfs/pentest.

### GET

- Download the repo

```bash
wget -c https://github.com/shellvik/shvbox/archive/refs/heads/master.zip -O shi3box.zip  && \
    unzip shi3box.zip && \
    rm -rf shi3box.zip && \
    mv shi3box-master shi3box
```

---

- OR **Clone**
  - _Trun off compression_:

```bash
git config --global core.compression 0
```

- _Partial clone_:

```bash
git clone --depth 1 https://github.com/shellvik/shi3box
```

- _Go into the new directory and retrive the rest of the clone_:

```bash
cd shvbox && \
git fetch --unshallow
```

- _Do a regular pull_:

```bash
git pull --all
```

---

### VBox Guest Additions

#### Install Linux Headers (Already in the init.sh script so skip this)

```bash
sudo apt update && \
sudo apt install -y linux-headers-$(uname -r) build-essential dkms
```

#### Enbale Vbox Guest Additions

- `Devices` > `Insert Guest Additions CD image…`
- Installation:

```bash
su root
cp /media/cdrom0/VBoxLinuxAdditions.run /root/
cd /root
./VBoxLinuxAdditions.run
```

---

### Run the install script

```bash
cd shi3box
sudo chmod +x init.sh
```

---

### Choose theme and fonts

```bash
lxappearance
```

- Select font: JetBrains Mono Regular 12
- Select Theme: Arc-Dark

---

### VPN(Keep it at right place)

- Store OpenVPN file at: `/etc/vpn-config/`
- Academy vpn: `aca-htb.ovpn`
- Lab vpn: `lab-htb.ovpn`

```bash
mv acavpnfile.ovpn /etc/vpn-config/aca-htb.ovpn
```

```bash
mv labvpnfile.ovpn /etc/vpn-config/lab-htb.ovpn
```

- Usage:

```bash
shvpn {aca|lab}
```

---
