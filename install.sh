
if [[ $# != 1 ]]; then
    echo Usage:
    echo 
    echo "sudo ./install.sh installDirectory"
else

    #inject into bashrc
    userBashRC="${HOME}/.bashrc"
    echo "" >> ${userBashRC} 
    echo "#USED FOR ANNOTATEHIST" >> ${userBashRC}
    echo "shopt -s histappend" >> ${userBashRC}
    echo "PROMPT_COMMAND='history -a;echo CWD \`pwd\` >> \${HOME}/.bash_history'" >> ${userBashRC}
    echo "alias markHist='${1}/setHistMark.sh'" >> ${userBashRC}
    echo "alias annotateHist='${1}/annotateHistory.sh'" >> ${userBashRC}
    echo "export ANN_HIST_DIR=${1}" >> ${userBashRC}

    #copy files
    if [[ ! -d ${1} ]]; then
        mkdir ${1}
    fi

    cp `pwd`/* ${1}/

    #source all bashrc changes
    source ${userBashRC}
    
fi


