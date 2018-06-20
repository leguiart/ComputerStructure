def mul(x,y):
    cont=0
    aux=0
    while(cont<y):
        aux+=x
        cont+=1
    return aux

def fact(x):
    cont=2
    aux=2
    if x<2:
        return 1
    else:
        while cont<=x:
            if cont==2:
                aux=mul(aux,cont-1)
            else:
                aux=mul(aux,cont)
            cont+=1
    return aux


print fact(30)
