
if [[ $# != 1 ]]; then
    echo usage:
    echo 
    echo annotateHist "\"Title of History Entry\""
    echo Spaces will be converted to underscores
    exit 1
fi

python ${ANN_HIST_DIR}/filterHistory.py filterHistory ${HOME}/.bash_history ${1// /_} ${ANN_HIST_DIR}/ignore_start.txt | vim - -c "f ${ANN_HIST_DIR}/histories/${1// /_}.history" +5

