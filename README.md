# proxmox_packer
First install packer for your local machine https://www.packer.io/downloads

Next configure your local credentials to manage the proxmox with your permissions by copying the local.pkvars.hcl.example and copy it to a local.auto.pkvars.hcl file

Next Run
```
packer init
```

Finally Run

```
packer build .
```
