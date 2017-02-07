#!/bin/bash
# Log everything we do.
set -x
exec > /var/log/user-data.log 2>&1

# TODO: actually, userdata scripts run as root, so we can get
# rid of the sudo and tee...

# Update the packages, install CloudWatch tools.
sudo yum update -y
sudo yum install -y awslogs
sudo curl -L "https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Create a config file for awslogs to log our user-data log.
cat <<- EOF | sudo tee /etc/awslogs/config/user-data.conf
    [/var/log/user-data.log]
    file = /var/log/user-data.log
    log_group_name = /var/log/user-data.log
    log_stream_name = {instance_id}
EOF

# Create a config file for awslogs to log our docker log.
cat <<- EOF | sudo tee /etc/awslogs/config/docker.conf
    [/var/log/docker]
    file = /var/log/docker
    log_group_name = /var/log/docker
    log_stream_name = {instance_id}
    datetime_format = %Y-%m-%dT%H:%M:%S.%f
EOF

# Start the awslogs service, also start on reboot.
# Note: Errors go to /var/log/awslogs.log
sudo service awslogs start
sudo chkconfig awslogs on

# Install Docker, add ec2-user, start Docker and ensure startup on restart
yum install -y docker
usermod -a -G docker ec2-user
sudo rm /etc/sysconfig/docker
cat <<- EOF | sudo tee /etc/sysconfig/docker
# The max number of open files for the daemon itself, and all
# running containers.  The default value of 1048576 mirrors the value
# used by the systemd service unit.
DAEMON_MAXFILES=1048576

# Additional startup options for the Docker daemon, for example:
# OPTIONS="--ip-forward=true --iptables=true"
# By default we limit the number of open files per container
OPTIONS="-D --default-ulimit nofile=1024:4096"

# How many seconds the sysvinit script waits for the pidfile to appear
# when starting the daemon.
DAEMON_PIDFILE_TIMEOUT=10
EOF

service docker start
chkconfig docker on
sudo mkdir /root/.docker

cat <<- EOF | sudo tee /root/.docker/config.json
{
	"auths": {
		"${registry}": {
			"auth": "${hub_token}"
		}
	}
}
EOF

docker run -d --name=${bot_name} ${bot_envs} ${bot_ports} ${bot_container_registry}/${bot_image_name}:${bot_image_tag}
docker run -d docker run -d --name=${bot_name_2} ${bot_envs_2} ${bot_ports_2} ${bot_container_registry_3}/${bot_image_name_3}:${bot_image_tag_2}
docker run -d --link ${bot_link_1} --link ${bot_link_2} --name=${bot_name_3} ${bot_ports_3} ${bot_container_registry_#}/${bot_image_name_3}:${bot_image_tag_3}
