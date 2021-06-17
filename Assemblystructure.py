
class Assemstruct(object):
    def __init__(self):
        self.count = 0
        self.lst = []
    def addcode(lst):
        self.lst = lst          
    def addline(line):
        self.lst.append(line)
    def getline(linenum):
        return self.linelst[linenum]
    def getlineword(line,wordnum):
        templine = self.lst[line]
        return templine[wordnum]
    def yieldword(word):
        for item in self.lst:
            for words in item:
                if words == word:
                    yield words

if __name__ == '__main__':
    test = Assemstruct()
    test.__init__()
    test.addline(["ADD","R3","R2","R1"])
