import Syntax
class Assemstruct(object):
    def __init__(self,labellst):
        self.count = 0
        self.errorindex = {}
        self.lst = []
        self.label = labellst
        self.acceptedlabels = ["add","mul","jsr","ret","ld","ldi","ldr","st","str","sti","and","not"]
    def addcode(self,lst):
        self.lst = lst          
    def addline(line):
        self.lst.append(line)
    def getline(self,linenum):
        return self.linelst[linenum]
    
    def getlineword(self,line,wordnum):
        templine = self.lst[line]
        return templine[wordnum]
    def yieldword(self,word):
        for item in self.lst:
            for words in item:
                if words == word:
                    yield words
    def labelcheck(self):
        
        self.errorindex = []
        count = 0
        for label in self.label:
            if label.lower() not in self.acceptedlabels:
                for acceptedlabel in self.acceptedlabels:
                    self.errorindex[acceptedlabel] = Errorindex(label,acceptedlabel)
                    self.errorindex()
                    count +=1
            
                print("Potential label at line " + str(count) + " : " + self.lst[count].join(" ") + "/n Did you mean to say" + str(selferror.index()
            else:
                count +=1
                                
                
                
                
                
        
                    

if __name__ == '__main__':
    test = Assemstruct()
    test.__init__()
    test.addline(["ADD","R3","R2","R1"])
