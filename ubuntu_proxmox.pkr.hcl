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
   qemu_agent = true

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
         cache_mode = "writeback"
   }
} 

build {
  sources = ["source.proxmox-iso.proxmox_ubuntu_20"]
  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    inline = [
      "sudo apt update",
      "sudo apt upgrade -y",
      "sudo apt install -y vim curl wget",
      "sudo sed -e 's/GRUB_CMDLINE_LINUX_DEFAULT=\".*\"/GRUB_CMDLINE_LINUX_DEFAULT=\"console=tty1 console=ttyS0\"/g' -i /etc/default/grub",
      "sudo update-grub",
      "sudo sed -e 's/datasource_list:.*/datasource_list: [ NoCloud ]/g' -i /etc/cloud/cloud.cfg.d/99-installer.cfg",
      "sudo cat /etc/cloud/cloud.cfg.d/99-installer.cfg"
    ]
  }

  post-processor "shell-local" {
    inline = [
      "ssh root@${var.proxmox_host} qm set ${var.vm_id} --scsihw virtio-scsi-pci",
      "ssh root@${var.proxmox_host} qm set ${var.vm_id} --ide2 ${var.storage_pool}:cloudinit",
      "ssh root@${var.proxmox_host} qm set ${var.vm_id} --boot c --bootdisk scsi0",
      "ssh root@${var.proxmox_host} qm set ${var.vm_id} --ciuser ${var.vm_user}",
      "ssh root@${var.proxmox_host} qm set ${var.vm_id} --cipassword ${var.vm_pass}",
      "ssh root@${var.proxmox_host} qm set ${var.vm_id} --ipconfig0 \"ip=${var.vm_ip}/24,gw=${var.vm_gateway}\"",
      "ssh root@${var.proxmox_host} qm set ${var.vm_id} --vga std"
    ]
  }
}


