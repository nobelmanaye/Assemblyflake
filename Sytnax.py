def Errorindex(word, standard):
        distanceindex ={}
        count = 1
        Error = 0
        row1 = "qwertyuiop[]"
        row2 = "asdfghjkl;'"
        row3 = "zxcvbnm,./"









        for letter in row1:
                distanceindex[letter.lower()] = (count,1)

                count += 1
        count = 1
        for letter in row2:
                distanceindex[letter.lower()] = (count,2)
                count += 1
        count = 1
        for letter in row3:
                distanceindex[letter.lower()] = (count,3)
                count +=1

        count = 0


        if len(word) < len(standard):
            for letter in word:
                    if letter in distanceindex:
                        Error += distance(distanceindex[letter.lower()],distanceindex[standard[count].lower()])
                        count +=1
                    else:
                        Error += 4
                        count+= 1


        else:
            for letter in standard:
                    if letter in distanceindex:
                        Error += distance(distanceindex[letter.lower()],distanceindex[word[count].lower()])
                        count +=1
                    else:
                        Error += 3
                        count+= 1
        return (Error**(0.5))/len(word)
        

			

def distance(a,b):
	horizontal = (a[0] - b[0])**2
	vertical  = (a[0] - b[0])**2
	return (horizontal +vertical)**0.5

stringlist = [["add","Add"],["Subtract","suBtraCT"],["multiply","multiply"]]

for item in stringlist:
        print("The error index of " + " and " + item[0] + " and " + item[1])
        print(str(Errorindex(item[0],item[1])))
              
