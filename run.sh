#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright 2020 jo-hannes

# Does all to install the dot files

# install ansible with given pkg mgr
function installAnsible() {
    if command -v "ansible" > /dev/null; then
        # ansible command available => do nothing
        return 0
    fi

    # find the package manager used in this system
    # All available package manager
    # dnf       Fedora
    # yum       RHEL, CentOS
    # apt-get   Debian, Ubuntu
    # pip   
    # pip3      MacOS
    local PKG_MANAGER="dnf yum apt-get pip pip3"
    local pkgMgr
    for cmd in ${PKG_MANAGER}
    do
        if command -v "${cmd}" > /dev/null; then
            pkgMgr="${cmd}"
            break
        fi
    done
    if [[ -z "${pkgMgr}" ]]; then
        echo "Error: No package manager found"
        return 1
    fi

    # install ansible
    # we need root for installation
    if [[ "$EUID" -eq 0 ]]; then
        "${pkgMgr}" install ansible
        return $?
    else
        echo "Note: We are not root, trying sudo"
        sudo "${pkgMgr}" install ansible
        return $?
    fi
}

function main() {
    # check if ansible is installed
    echo "## Checking Ansible installation ##"
    if ! installAnsible; then
        echo "Error: Unable to install ansible"
        return 1
    fi
    echo "## Installing required roles form galaxy ##"
    echo "TODO"
    if ! ansible-galaxy install -r requirements.yml; then
        echo "Error: Unable to install roles form ansible galaxy"
        return 1
    fi
    echo "## Running Ansible playbook ##"
    if ! ansible-playbook dotfiles.yml; then
        echo "Error: Unable to run playbook"
        return 1
    fi
}

main "$@"
exit $?
