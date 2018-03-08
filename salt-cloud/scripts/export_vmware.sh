#!/bin/sh
#
# Script d'export du vcenter par SALT-CLOUD
#
# 20/12/2016 : Martin LEKPA : Creation du script

EXEC=salt-cloud
CIBLE='vcenter_hostname'
REPOUT=/REP

${EXEC} -f list_nodes_select ${CIBLE} --out=json --out-file=${REPOUT}/export_vm.json
sed -i "/${CIBLE}/d" ${REPOUT}/export_vm.json
sed -i '/vmware/d' ${REPOUT}/export_vm.json
sed -i '$d' ${REPOUT}/export_vm.json
sed -i '$d' ${REPOUT}/export_vm.json
sed -i 's/ram:/<\/br>ram:/g' ${REPOUT}/export_vm.json

${EXEC} -f list_hosts_by_cluster ${CIBLE} --out=json --out-file=${REPOUT}/export_esx.json