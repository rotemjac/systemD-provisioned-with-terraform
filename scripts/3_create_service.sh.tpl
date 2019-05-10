#!/usr/bin/env bash

cd /etc/systemd/system/
sudo touch ${service_name}.service

cat << 'EOF' > /etc/systemd/system/${service_name}.service
    [Unit]
    Description=${service_name} Http Server
    [Service]
    PIDFile=/tmp/${service_name}-$(pid_num).pid
    User=${service_user}
    Group=${service_group}
    Restart=always
    KillSignal=SIGQUIT
    ExecStart=/usr/bin/sudo ${execution_command} ${home_dir}/${path}
    [Install]
    WantedBy=multi-user.target
EOF

sudo systemctl enable ${service_name}.service
systemctl daemon-reload


### If you want the provision to be finished with the service running - uncomment this
sudo systemctl start ${service_name}.service


### Debugging ###
#sudo journalctl -fu ${service_name}.service
#sudo systemctl restart ${service_name}.service
#sudo systemctl status ${service_name}.service
#cat system.conf
#service --status-all