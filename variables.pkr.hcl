variable "vm_pass" {
   type = string
   description = "vm pass"
}

variable "password" {
   type = string
   description = "proxmox password"
}

variable "username" {
   type = string
   description = "proxmox username"
   default = "root@pam"
}

variable "vm_name" {
   type = string
   description = "vm name"
   default = "ubuntu-20.04-template"
}

variable "vm_ip" {
   type = string
   description = "vm ip address"
   default = "192.168.1.254"
}

variable "vm_user" {
   type = string
   description = "vm username"
   default = "chad"
}

variable "proxmox_url" {
   type = string
   description = "url for proxmox server"
   default = "https://192.168.1.23:8006/api2/json"
}

variable "vm_disk_size" {
   type = string
   description = "size of vm disk"
   default = "15G"
}

variable "storage_pool" {
   type = string
   description = "storage pool for vm disk"
   default = "local-lvm"
}

variable "node" {
   type = string
   description = "proxmox node name"
   default = "proxtest1"
}

variable "iso_url" {
   type = string
   description = "url for iso"
   default = "https://releases.ubuntu.com/20.04/ubuntu-20.04.4-live-server-amd64.iso"
}

variable "iso_storage_pool" {
   type = string
   description = "storage pool for iso file"
   default = "local"
}

variable "iso_checksum" {
   type = string
   description = "checksum for iso file"
   default = "28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
}

variable "skip_tls" {
   type = bool
   description = "whether to check tls hostname (vuln to mitm)"
   default = false
}
