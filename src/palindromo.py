cadena=raw_input("Introducir cadena a evaluar si es un palindromo: ")
def palindromo(string):
    s=[]
    l=[]
    cont=0
    for i in string:
        if i!=' ':
            s.append(i)
    for i in s:
        l.append(i)
        cont+=1
    cont-=1
    for i in range(len(l)):
        if s[i]!=l[cont]:
            print "No es un palindromo"
            return 0
        cont-=1
    print "Es un palindromo"

palindromo(cadena)    
