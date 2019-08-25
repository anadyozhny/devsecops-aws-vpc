#!/bin/bash -x

hostname="bastion"
user="ec2-user"
user_home=$(eval echo ~$user)
bashrc="$user_home/.bashrc"
aws_dir="$user_home/.aws"
ssh_dir="$user_home/.ssh"

sudo hostname $hostname
sudo hostnamectl set-hostname "$hostname.localdomain"

[ -d $aws_dir ] || mkdir -p $aws_dir
cat << EOF >> $aws_dir/config
[default]
region = eu-central-1
output = json

EOF
chown -R $user:$user $aws_dir

cat << EOF >> $bashrc

# Get running EC2 Instances tagged with Name=Internal
get_running_instances ()
{
  if [ -x /usr/bin/jq ]; then
    aws ec2 describe-instances \\
      --filters \\
          "Name=instance-state-name,Values=running" \\
          "Name=tag:Name,Values=Internal" \\
      | jq -c -r '.Reservations[].Instances[] | [.InstanceId, .NetworkInterfaces[].PrivateIpAddresses[].PrivateIpAddress]'
  else
    aws ec2 describe-instances \\
      --query "Reservations[*].Instances[*].[InstanceId,NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress]" \\
      --filters "Name=instance-state-name,Values=running" "Name=tag:Name,Values=Internal"
  fi
}

EOF

[ -d $ssh_dir ] || mkdir -p $ssh_dir
ssh-keygen -qo -b 4096 -t rsa -C Bastion-Host -P '' -f $ssh_dir/id_rsa
chown -R $user:$user $ssh_dir/id_rsa

sudo yum -y install jq python2-pip
sudo pip install ec2instanceconnectcli
sudo yum -y update
