''' This program runs other sub-modules to parse, check and display error messages of assembly code where they appear'''

from scanner import scan

def main(file=""):
        
        while True:
                if file == "":

                        filename = input("input name of assembly file ")
                        filename.lower()

                        if type(filename) == str:

                                if filename[-3:] == "asm":
                                        scan(filename)
                                        
                                else:
                                        print(filename[:3])
                                        print(filename," is not an asm file. Please enter an asm file")
                        else:
                                print("Non-string file name entered, please enter a string file name")

                if file != "":
                        scan(file)
                        break
                        
                

        


if __name__ == '__main__':
        main("factorial.asm")

