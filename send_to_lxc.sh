#!/usr/bin/bash

function usage () {
    echo "Usage: bash send_to_lxc.sh container_name user_name"
}

if [ "$#" -ne 2 ]; then
    usage
    exit
fi

CONTAINER="$1"
USERNAME="$2"

cont_exists=$(lxc list | grep -w "$CONTAINER" )

if [ -z "$cont_exists" ]; then
    echo "Container with this name does not exist: $CONTAINER"
    exit
fi

lxc exec $CONTAINER -- mkdir -p /home/$USERNAME/.config/nvim/
lxc file push ./init.vim $CONTAINER/home/$USERNAME/.config/nvim/
lxc file push ./tmux.conf $CONTAINER/home/$USERNAME/
