compile_new_kernel(){
yum --disablerepo="*" --enablerepo="elrepo-kernel" list available | grep kernel-ml
yum -y --enablerepo=elrepo-kernel install kernel-ml
yum -y --enablerepo=elrepo-kernel install kernel-ml-{devel,headers,perf}
echo "GRUB_DEFAULT=0" >> /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
}

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd
yum -y install https://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
yum install -y epel-release 
yum update -y
compile_new_kernel
