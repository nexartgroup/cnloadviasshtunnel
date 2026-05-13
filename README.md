# cnloadviasshtunnel

**Send Click'n'Load Links via SSH to JDownloader on a NAS or other Device (MAC)**

`cnloadviasshtunnel` is a lightweight Bash script that allows you to securely send Click'n'Load (CNL) links to JDownloader running on a NAS or any other remote device via an SSH tunnel. This is especially useful for macOS users who want to manage downloads on a remote JDownloader instance without exposing it directly to the network.

---

## Features

* **Easy toggle of SSH tunnel**: Start or stop the Click'n'Load tunnel with a single command.
* **Automatic detection**: Checks if the tunnel is already running and stops it before restarting.
* **Secure**: Uses SSH port forwarding to connect to the remote JDownloader safely.
* **Visual feedback**: Displays a stylized banner and clear status messages.
* **Configurable**: Quickly modify NAS credentials, host IP, and port settings.

---

## Requirements

* macOS or Linux system with Bash
* SSH access to the remote NAS or server
* JDownloader running on the remote device
* `lsof` command installed (usually preinstalled on macOS/Linux)

---

## Configuration

Edit the top of the script to match your environment:

```bash
VERSION="0.1 Alpha"
NAS_USER="admin"           # SSH username
NAS_HOST="192.168.1.1"     # NAS IP or hostname
LOCAL_PORT="9666"          # Local port for Click'n'Load
REMOTE_PORT="9666"         # Remote JDownloader port
```

---

## Usage

1. Make the script executable:

```bash
chmod +x cnloadviasshtunnel.sh
```

2. Run the script:

```bash
./cnloadviasshtunnel.sh
```

* If the tunnel is **already running**, it will stop the existing tunnel.
* If the tunnel is **not running**, it will establish an SSH tunnel to your NAS.

Once active, you can send Click'n'Load links to your remote JDownloader by pointing your browser or extension to `http://127.0.0.1:9666`.

---

## Example Output

```
Click'n'Load Tunnel already running.
USER:admin PID:12345 STARTED:10:30 /usr/bin/ssh -L 9666:127.0.0.1:9666 admin@192.168.1.1
Tunnel stopped.

Starting Click'n'Load Tunnel via SSH Tunnel...
Tunnel started successfully.
127.0.0.1:9666 ► 192.168.1.1:9666
```

---

## License

This project is currently in **Alpha** stage. Use at your own risk.


