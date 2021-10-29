create_raid1(){
    yes | mdadm --create --verbose /dev/md01 --level=1 --raid-devices=2 /dev/sdd /dev/sde
    mkfs.ext4 -F /dev/md01
    mkdir -p /mnt/md01
    mount /dev/md01 /mnt/md01
    echo '/dev/md01 /mnt/md01 ext4 defaults,nofail,discard 0 0' | sudo tee -a /etc/fstab
}

create_raid10(){
    mdadm --create --verbose /dev/md10 --level=10 --raid-devices=4 /dev/sdc /dev/sdf /dev/sdg /dev/sdh
    mkfs.ext4 -F /dev/md10
    mkdir -p /mnt/md10
    mount /dev/md10 /mnt/md10
    echo '/dev/md10 /mnt/md10 ext4 defaults,nofail,discard 0 0' | sudo tee -a /etc/fstab
}

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd
yum install -y epel-release mdadm
yum update -y
create_raid1
create_raid10
df -h -x devtmpfs -x tmpfs
