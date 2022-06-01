# terraform-aws-spot-ec2-arm

Initalize terraform:
```bash
terraform init
```

Deploy Spot EC2 instance:
```bash
export TF_VAR_attach_second_interface=false
terraform apply -auto-approve

export TF_VAR_attach_second_interface=true
terraform apply -auto-approve
```

Update your netplan configuration:
```bash
sudo vim /etc/netplan/50-cloud-init.yaml
```
```yaml
network:
    ethernets:
        ens5:
            dhcp4: true
            dhcp6: false
            match:
                macaddress: 02:7c:d7:e8:c8:01
            set-name: eth0
        ens6:
            addresses:
            - 172.31.17.61/20
            dhcp4: false
            dhcp6: false
            match:
                macaddress: 02:c3:3f:32:cf:e1
            set-name: eth1
    version: 2
```


### terraform workspace

List all workspaces:
```bash
terraform workspace list
```

Create new workspace:
```bash
terraform workspace new 2nd-vm
```

Apply changes:
```bash
terraform apply -auto-approve
```

