#!/bin/bash

SetLocale() {
    echo -e "LANG=en_US.UTF-8\nLC_ALL=C\n\nexport LANG\nexport LC_ALL" > /etc/profile.d/setlocale.sh
    chmod 755 /etc/profile.d/setlocale.sh
    /etc/profile.d/setlocale.sh
}

PutYumRepoMesosphere() {
    curl -L https://raw.githubusercontent.com/tamama/repository/master/etc/yum.repos.d/mesosphere.repo \
        -o /etc/yum.repos.d/mesosphere.repo

    curl -L https://raw.githubusercontent.com/tamama/repository/master/etc/pki/rpm-gpg/RPM-GPG-KEY-mesosphere \
        -o /etc/pki/rpm-gpg/RPM-GPG-KEY-mesosphere
}

PutYumRepo() {
    PutYumRepoMesosphere $@
}

UpdateYum() {
    yum install -y epel-release
    yum repolist
    yum update -y
}

DownloadRpmDnf() {
    mkdir -p /usr/local/src/rpm/tamama-third-party/infrastructure/dnf/0.6.4

    curl -L http://163.172.190.239:50080/tamama/repository/rpm/tamama/third-party/infrastructure/dnf/0.6.4/dnf-conf-0.6.4-2.el7.noarch.rpm \
        -o /usr/local/src/rpm/tamama-third-party/infrastructure/dnf/0.6.4/dnf-conf-0.6.4-2.el7.noarch.rpm
    curl -L http://163.172.190.239:50080/tamama/repository/rpm/tamama/third-party/infrastructure/dnf/0.6.4/python-dnf-0.6.4-2.el7.noarch.rpm \
        -o /usr/local/src/rpm/tamama-third-party/infrastructure/dnf/0.6.4/python-dnf-0.6.4-2.el7.noarch.rpm
    curl -L http://163.172.190.239:50080/tamama/repository/rpm/tamama/third-party/infrastructure/dnf/0.6.4/dnf-0.6.4-2.el7.noarch.rpm \
        -o /usr/local/src/rpm/tamama-third-party/infrastructure/dnf/0.6.4/dnf-0.6.4-2.el7.noarch.rpm
}

YumInstallKernelDevel() {
    yum install -y kernel-devel
}

YumInstallDnf0() {
    yum install -y dnf
}

YumInstallDnf1() {
    yum install -y python-hawkey python-libcomps python-librepo

    DownloadRpmDnf

    yum localinstall -y /usr/local/src/rpm/tamama-third-party/infrastructure/dnf/0.6.4/dnf-conf-0.6.4-2.el7.noarch.rpm
    yum localinstall -y /usr/local/src/rpm/tamama-third-party/infrastructure/dnf/0.6.4/python-dnf-0.6.4-2.el7.noarch.rpm
    yum localinstall -y /usr/local/src/rpm/tamama-third-party/infrastructure/dnf/0.6.4/dnf-0.6.4-2.el7.noarch.rpm	
}

main() {
    SetLocale $@
    PutYumRepo $@
    UpdateYum $@
    YumInstallKernelDevel $@
    YumInstallDnf0 $@
    #YumInstallDnf1 $@
}

if [ "${BASH_SOURCE[0]}" == "$0" ]; then
    main $@
fi
