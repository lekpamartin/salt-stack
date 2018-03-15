#!/bin/bash

MAPREP=/etc/salt/cloud.profiles.d/map

COMMANDES="
Les commandes suivantes sont disponibles :
 * -y/--yes: autovalidation
 * -d/--destroy: supprimer la VM
 * --start <VM>: demarrer une VM
 * --stop: arreter une VM
 * -r/--restart: redemarrer la VM
 * -m/--map: deployer les VMs dans le fichier fourni
"

usage() {
        echo "
Erreur de syntaxe:

        $0 [-h/--help] [-y/--yes] [-l/--log] [-p/--parallel] [-d/--destroy <VM>] [--start <VM>] [--stop <VM>] [-r/--restart <VM>] [-m/--map file.map]

        ${COMMANDES}"
}

create() {
        if [ -f ${MAPREP}/${MAP} ]; then
                salt-cloud ${YES} ${LOG} ${PARALLEL} -m ${MAPREP}/${MAP}
        else
                echo "${MAPREP}/${MAP} n'existe pas"
        fi
}

if [ $# -lt 1 ]; then
        usage
        exit 1
fi

while [ "$1" != "" ]; do
    case $1 in
        -h | --help )
                CMD=usage;;
        -y | --yes )
                shift
                YES="-y";;
        -l | --log )
                shift
                LOG="-l debug";;
        -p | --parallel)
                shift
                PARALLEL="-P";;
        -d | --destroy )
                shift
                VM=$1
                CMD="salt-cloud -d ${VM}";;
        --start )
                shift
                VM=$1
                CMD="salt-cloud -a start ${VM}";;
        --stop )
                shift
                VM=$1
                CMD="salt-cloud -a stop ${VM}";;
        -r | --restart )
                shift
                VM=$1
                CMD="salt-cloud -a stop ${VM}
salt-cloud -a start ${VM}";;
        -m | --map )
                shift
                MAP=$1
                CMD=create;;
        * )
                CMD=usage;;
    esac
    shift
done


${CMD} ${YES} ${LOG}
exit $?