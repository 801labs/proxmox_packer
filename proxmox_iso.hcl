{
  "variables": {
    "username": username,
    "password": password,
    "node": node,
    "iso_file": iso_file,
    "proxmox_url": proxmox_url
  }
  "builders": [
     "type": "proxmox",
     "proxmox_url": "https://192.168.1.13:8006/api2/json",
     "insecure_skip_tls_verify": true,
     "username": "{{user `username`}}",
     "password": "{{password `password`}}",
 
     "node": "{{node `node`}}",
     "boot_command": [
        "echo \"we did it\""
     ],

     "network_adapters": [
        {
           "ethernet": "eno2"
        }
     ], 
     "iso_file": "{{isofile `isofile`}}",
     "unmount_iso": true
     
  ]
}
