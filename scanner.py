"""

This code scans a file and outputs a condensed, numbered list containing of the assembly code

"""

def scan(inputfile):
    "This file scans an assembly code and returns a list whose items are the numbered lines of the code"
    
    
    numberedcodels = []  
    codefile = open(inputfile,"r")              #read the file containing the assembly code
    Line = codefile.readlines()
    count = 0
    for line in Line:
        
        print(Line)
