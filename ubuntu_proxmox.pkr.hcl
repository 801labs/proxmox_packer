packer {
   required_plugins {
      proxmox = {
         version = " >= 1.0.1"
         source = "github.com/hashicorp/proxmox"
      }
   }
}
source "proxmox-iso" "proxmox_ubuntu_20" {
   proxmox_url = var.proxmox_url
   insecure_skip_tls_verify = var.skip_tls
   username = var.username
   password = var.password

   
   ssh_username = var.vm_user
   ssh_password = var.vm_pass
   ssh_timeout  = "20m"
   ssh_handshake_attempts  = "20"
   ssh_host = var.vm_ip

   
   node = var.node
   os = "l26"
   
   template_name = var.vm_name

   iso_storage_pool = var.iso_storage_pool
   iso_checksum = var.iso_checksum
   iso_url = var.iso_url
   unmount_iso = true

   cores = "2"
   memory = "2048"
  
   http_directory = "http-dir"
   http_port_min = "8080"
   http_port_max = "8080"
   qemu_agent = false
   cloud_init = true
   cloud_init_storage_pool = var.iso_storage_pool

   boot_wait = "5s"
   boot_command = [
       "<esc><wait><esc><wait><f6><wait><esc><wait>",
       "<bs><bs><bs><bs><bs>",
       "ip=dhcp autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
       "<enter><wait>",
   ]


   network_adapters {
         model = "virtio"
         bridge = "vmbr0"
   }
   
   disks {
         type = "scsi"
         disk_size = var.vm_disk_size
         storage_pool = var.storage_pool
         storage_pool_type = "lvm"
   }
} 

build {
  sources = ["source.proxmox-iso.proxmox_ubuntu_20"]
  provisioner "shell" {
    inline = [
      "ls /"
    ]
  }
}


