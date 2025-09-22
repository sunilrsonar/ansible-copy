#!/bin/bash

ANSIBLE_PUB_KEY=$(cat ~/.ssh/id_rsa.pub)
PEM_FILE="key_file.pem"

for ip in $(cat ec2_ip_list.txt); do
    echo "copying the key pair to server $ip"
    ssh -o StrictHostKeyChecking=no -i $PEM_FILE ubuntu@$ip "
        mkdir -p ~/.ssh
        echo '$ANSIBLE_PUB_KEY' >> ~/.ssh/authorized_keys
        chmod 700 ~/.ssh
        chmod 600 ~/.ssh/authorized_keys
        "
done