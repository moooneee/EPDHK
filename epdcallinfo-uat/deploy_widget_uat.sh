#!/bin/bash

NODES=("10.17.20.133" "10.17.20.135" "10.17.20.136")

FILE="epdcallinfouat.tar"

COMMAND1="ctr -n k8s.io images rm eptce-docker-hosted.forge.avaya.com/epdcallinfouat:0.0.1"
COMMAND2="ctr -n k8s.io images import epdcallinfouat.tar"

for NODE in "${NODES[@]}"; do
    echo "Copying $FILE to $NODE"
    scp "$FILE" "$NODE:/home/brix/" &
done

wait

for NODE in "${NODES[@]}"; do
    echo "Connecting to $NODE to execute commands"
    ssh "$NODE" "$COMMAND1; $COMMAND2" &
done
