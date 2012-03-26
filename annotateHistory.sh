
if [[ $# != 1 ]]; then
    echo usage:
    echo 
    echo annotateHist "\"Title of History Entry\""
    echo Spaces will be converted to underscores
    exit 1
fi

pypy ${HOME}/histories/scripts/filterHistory.py filterHistory ${HOME}/.bash_history ${1// /_} ${HOME}/histories/scripts/ignore_start.txt | vim - -c "f ${HOME}/histories/${1// /_}.history" +5

