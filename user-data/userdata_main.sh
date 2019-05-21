#!/bin/bash

install_deps(){
    apt update 
    apt install -y docker.io   # python-pip libssl-dev git
    pip install awscli ansible
}
deploy(){
    useradd -m -s /bin/bash deploy
    gpasswd -a deploy docker
    su - deploy -c 'docker run -d --restart=always -p3000:3000 thapakazi/hug.rest-py'
}

install_deps
deploy
