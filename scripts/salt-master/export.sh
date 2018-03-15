#!/bin/sh
#
# Script d'export de conf SALT
#
# 29/09/2016 : Martin LEKPA : Creation du script

EXEC=salt
CIBLE='*'
LIST="grains.item state.apply"
REPOUT=/share/data/saltstack/export
DATE=`date '+%Y-%m-%d %T'`


for i in ${LIST}; do

        case "$i" in
                grains.item)
                        ARGS="env_name env_type vm_type"
                        #CIBLE='*'
                        OUT=${REPOUT}/grains.html;;
                state.apply)
                        ARGS="test=True"
                        #CIBLE='*'
                        OUT=${REPOUT}/status.html;;
        esac


        echo "Ce fichier est genere le ${DATE} par le script export.sh<body><pre>" > ${OUT}
        ${EXEC} "${CIBLE}" ${i} ${ARGS} --no-color >> ${OUT}

        echo "</pre><body>" >> ${OUT}

done