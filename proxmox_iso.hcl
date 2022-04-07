{
  "variables": {
    "username": "",
    "password": "",
    "vm_pass": "",
    "vm_user": "",
    "vm_name": "",
    "node": "",
    "iso_url": "",
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

     
     "ssh_username": "{{ user `vm_user` }}",
     "ssh_password": "{{ user `vm_pass` }}",
     
     "node": "{{user `node`}}",
     
     "template_name": "{{ user `vm_name` }}",
     "qemu_agent": "true",
     "cloud_init": "true",

     "bios": "ovmf",
     "efidisk": "local-lvm",

     "iso_storage_pool": "{{user `iso_storage_pool`}}",
     "iso_checksum": "{{user `iso_checksum`}}",
     "iso_url": "{{user `iso_url`}}",
     "unmount_iso": true,

     "cores": "2",
     "memory": "2048",
    
     "http_directory": "./http-dir",
     "http_port_min": "8080",
     "http_port_max": "8080",

     "boot_wait": "5s",
     "boot_command": [
	"<esc><wait><esc><wait><f6><wait><esc><wait>",
	"<bs><bs><bs><bs><bs>",
        "hostname={{ user `vm_name` }} ",
        "passwd/username={{ user `vm_user` }} ",
        "passwd/password={{ user `vm_pass` }} ",
        "passwd/user-password-again={{ user `vm_pass` }} ",
        "passwd/user-password-again={{ user `vm_pass` }} ",
        "ip=dhcp ",
        " autoinstall/enable=true",
        " debconf/priority=critical",
        " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
        " -- <wait>",
        "<enter><wait>"
     ],


     "network_adapters": [
        {
           "model": "virtio",
           "bridge": "vmbr0"
        }
     ],
     
     "disks": [
        {
           "type": "scsi",
           "disk_size": "15G",
           "storage_pool": "local-lvm",
           "storage_pool_type": "lvm"
        }
     ]

    } 
  ]
}
