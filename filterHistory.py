from datetime import date 
import time

def removeRunningDuplicates(theList):

    prevItem = ''
    newList = []
    for item in theList:
        if item == prevItem:
            continue 
        else:
            newList.append(item) 
            prevItem = item 

    return newList            
        

def filterHistory(histFile, histTitle, ignoreFN):
    
    today = date.today()
    secs = time.time() #current seconds, for sorting 

    ignoreStartList = []
    f = open(ignoreFN, 'r')
    for line in f:
        ls = line.split(',')
        ignoreStartList.append(ls[0])
    f.close()
    
    
    fileLines = open(histFile, 'r').readlines()

    #remove running duplicates (first pass: for CWD) 
    fileLines = removeRunningDuplicates(fileLines)

    #only deltaCWD are recorded 
    #(Note: CWD lines dont have to be swapped because all the cds will be caught )
    cwd = ''
    newFileLines = []
    for line in fileLines:
        if line.startswith('CWD'):
            newCWD = line

            #if it is not new, skip, else keep and change 
            if newCWD == cwd:
                continue
            else:
                cwd = newCWD

        newFileLines.append(line)                



    #reverse so we take everything after the mark 
    newFileLines.reverse()

    #parse out relevent lines 
    releventLines = [' ']
    prevLine = '' #only lines with stuff, no CR
    for line in newFileLines:
        
        #check for Mark, else filter, else add 
        if line.startswith('HISTMARK'): break
        
        #no lines that start with words in ignore list 
        if any([line.startswith(x) for x in ignoreStartList]): continue
        
        #only show most recent CWD if next to each other
        #basically if you only switched directories, show newest
        #note this is in reverse so keep FIRST
        if line.startswith('CWD'):
            if releventLines[-1].startswith('CWD'): continue 

        #filters out running same "relevent" thing in a row 
        if line == prevLine: continue 


        releventLines.append(line)
        prevLine = line 
    
    
    releventLines.reverse()

    #add CR after CWD 
    newReleventLines = []
    for line in releventLines:
        if line.startswith('CWD'):
            newReleventLines.extend(['\n', line])
        else:
            newReleventLines.append(line) 

    print secs
    print today
    print '[ %s ]\n\n\n\n----------------------------------\n' % histTitle
    for l in newReleventLines:
        print l.strip()

     
if __name__ == "__main__":
    import sys
    assert sys.argv[1] in globals(), "Need name of fxn to run from command line!"
    fxnToRun = globals()[sys.argv[1]] 
    fxnToRun(*sys.argv[2:])
