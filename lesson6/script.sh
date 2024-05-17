#!/bin/bash
export ANSIBLE_DIR=/root/.local/bin

sudo yum install -y pip
python3 -m pip install --user ansible
sudo $ANSIBLE_DIR/ansible --version