#!/bin/bash

UpdateYum() {
    yum install -y epel-release
    yum repolist
    yum update -y
}

DownloadRpmDnf() {
    mkdir -p /usr/local/src/rpm/tamama-third-party/infrastructure/dnf/0.6.4
    
    curl -L https://tamama.000webhostapp.com/tamama/repository/rpm/tamama/third-party/infrastructure/dnf/0.6.4/dnf-conf-0.6.4-2.el7.noarch.rpm \
        -o /usr/local/src/rpm/tamama-third-party/infrastructure/dnf/0.6.4/dnf-conf-0.6.4-2.el7.noarch.rpm
    curl -L https://tamama.000webhostapp.com/tamama/repository/rpm/tamama/third-party/infrastructure/dnf/0.6.4/python-dnf-0.6.4-2.el7.noarch.rpm \
        -o /usr/local/src/rpm/tamama-third-party/infrastructure/dnf/0.6.4/python-dnf-0.6.4-2.el7.noarch.rpm
    curl -L https://tamama.000webhostapp.com/tamama/repository/rpm/tamama/third-party/infrastructure/dnf/0.6.4/dnf-0.6.4-2.el7.noarch.rpm \
        -o /usr/local/src/rpm/tamama-third-party/infrastructure/dnf/0.6.4/dnf-0.6.4-2.el7.noarch.rpm
}

YumInstallDnf() {
    yum install -y python-hawkey python-libcomps python-librepo

    DownloadRpmDnf

    yum localinstall -y /usr/local/src/rpm/tamama-third-party/infrastructure/dnf/0.6.4/dnf-conf-0.6.4-2.el7.noarch.rpm
    yum localinstall -y /usr/local/src/rpm/tamama-third-party/infrastructure/dnf/0.6.4/python-dnf-0.6.4-2.el7.noarch.rpm
    yum localinstall -y /usr/local/src/rpm/tamama-third-party/infrastructure/dnf/0.6.4/dnf-0.6.4-2.el7.noarch.rpm	
}

main() {
    UpdateYum $@
    YumInstallDnf $@
}

if [ "${BASH_SOURCE[0]}" == "$0" ]; then
    main $@
fi
