create_raid1(){
    echo "yes" | mdadm  --create --verbose /dev/md0 --force --auto=yes --level=1 --raid-devices=2 /dev/sdd /dev/sde 
    mkfs.ext4 -F /dev/md0
    mkdir -p /mnt/md0
    mount /dev/md0 /mnt/md0
    echo '/dev/md0 /mnt/md0 ext4 defaults,nofail,discard 0 0' | sudo tee -a /etc/fstab
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
