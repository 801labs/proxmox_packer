{
  "variables": {
    "username": "",
    "password": "",
    "node": "",
    "iso_file": "",
    "iso_storage_pool": "",
    "iso_checksum": "",
    "skip_tls": "",
    "proxmox_url": ""
  },
  "builders": [
    {
     "type": "proxmox",
     "proxmox_url": "{{user `proxmox_url`}}",
     "insecure_skip_tls_verify": "{{user `skip_tls`}}",
     "username": "{{user `username`}}",
     "password": "{{user `password`}}",
 
     "node": "{{user `node`}}",
     "ssh_username": "root",
     "boot_command": [
        "echo \"we did it\""
     ],

     "iso_storage_pool": "{{user `iso_storage_pool`}}",
     "iso_checksum": "{{user `iso_checksum`}}",
     "iso_url": "{{user `iso_url`}}",
     "unmount_iso": true
    } 
  ]
}
