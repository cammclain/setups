#! /bin/bash

# After the first reboot, you run this script to install the rest of the packages

revalidate_packages() {
    sudo apt update
    sudo apt upgrade -y
}


create_a_storage_pool_for_kvm_vms() {
    sudo mkdir -p /var/lib/libvirt/images
    sudo virsh pool-define-as default dir --target /var/lib/libvirt/images
    sudo virsh pool-start default
    sudo virsh pool-autostart default

}