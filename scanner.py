"""

This code scans a file and outputs a condensed, numbered list containing of the assembly code

"""
from Assemblystructure import Assemstruct

def scan(inputfile):
    "This file scans an assembly code and returns a list whose items are the numbered lines of the code"
    
    
    numberedcodels = []  
    codefile = open(inputfile,"r")              #read the file containing the assembly code
    Line = codefile.readlines()                 # Read all lines to Line
    count = 0
    stage1line = ''
    stage1linelst = []                          # Initialize all working lists and strings 
    stage2line = ''
    stage2linelst = []
    stage3linelst = []
    stage3wordlst =[]
    labellst = []
    wordlst = []
    newchar = ''

## =============================================================================================================================================================

    
    for line in Line:                           # For each line, remove the newline character, and copy them to stage1line
        stage1line = ''
        if line != "\n":
            stage1line = line[:-1]
            stage1linelst.append(stage1line)    # Append the lines whose newline character has been removed to stage1linelst

    for line in stage1linelst:                 # For each Line,remove the semicolon character and the following comment,then copy them to stage2line
        stage2line  = ''
        for character in line: 
            if character != ';':
                stage2line += character
            else:
                break
        stage2linelst.append(stage2line)      # Append the lines whose semicolon characters and comments have been removed to stage2linelst

    while '' in stage2linelst:                # Remove remaining '' string characters
    
        stage2linelst.remove('')          
        
        
      
        #register = Assemregister()


     
    for line in stage2linelst:
        splitline = line.split(" ")
        print("this is splitline ",splitline)
        while '' in splitline:
            splitline.remove("")
            #register.addline(splitline)
            print("/n this is splitline modified ",splitline)
        stage3linelst.append(splitline)

    for item in stage3linelst:
        labellst.append(item[0])

    return [stage3linelst,labellst]


