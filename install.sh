#!/bin/bash

if [[ $# != 1 ]]; then
    echo Usage:
    echo 
    echo "sudo ./install.sh installDirectory"
else

    #inject into bashrc
    #TODO
    #need to make sure you only inject once
    if [[ ! ${ANN_HIST_DIR} ]]; then
        #statements
        userBashRC="${HOME}/.bashrc"
        echo "" >> ${userBashRC} 
        echo "#USED FOR ANNOTATEHIST" >> ${userBashRC}
        echo "shopt -s histappend" >> ${userBashRC}
        echo "PROMPT_COMMAND='history -a;echo CWD \`pwd\` >> \${HOME}/.bash_history'" >> ${userBashRC}
        echo "export ANN_HIST_DIR=${1}" >> ${userBashRC}
    fi

    #copy files
    if [[ ! -d ${1} ]]; then
        mkdir ${1}
    fi

    cp -r `pwd`/* ${1}/

    #update links so commands autocomplete from CLI
    ln -s -T ${1}/annotateHistory.sh /usr/local/bin/annotateHist
    ln -s -T ${1}/setHistMark.sh /usr/local/bin/setHistMark

fi
