"""

This code scans a file and outputs a condensed, numbered list containing of the assembly code

"""
from Assemblystructure import Assemstruct

def scan(inputfile):
    "This file scans an assembly code and returns a list whose items are the numbered lines of the code"
    
    
    numberedcodels = []  
    codefile = open(inputfile,"r")              #read the file containing the assembly code
    Line = codefile.readlines()
    count = 0
    stage1line = ''
    stage1linelst = []
    stage2line = ''
    stage2linelst = []
    
    for line in Line:
        stage1line = ''
        if line != "\n":
            stage1line = line[:-1]
            stage1linelst.append(stage1line)

    for line in stage1linelst:
        stage2line  = ''
        for character in line:
            if character != ';':
                stage2line += character
            else:
                break
        stage2linelst.append(stage2line)

    while '' in stage2linelst:
        stage2linelst.remove('')

    for i in range(len(stage2linelst)):
        print(i,": ", stage2linelst[i])

    
        
    
    

