



def Errorindex(word, standard):
	distanceindex ={}
	count = 1
	Error = 0
	row1 = "qwertyuiop[]"
`	row2 = "asdfghjkl;'"
	row3 = "zxcvbnm,./"
	for letter in row1:
		distanceindex[letter] = (count,1)
		count += 1
	count = 1
	for letter in row2:
        	distanceindex[letter] = (count,2)
		count += 1
	count = 1
	for letter in row3:
		distanceindex[letter] = (count,3)
		count +=1

	count = 0
	for letter in word:
		if letter in distanceindex:
			Error += distance(distanceindex[letter],distanceindex[standard])
			count +=1
		else:
			Error += 4
			count+= 1

	return Error/len(word)

			

def distance(a,b):
	horizontal = (a[0] - b[0])**2
	vertical  = (a[0] - b[0])**2
	return (horizontal +vertical)**0.5
