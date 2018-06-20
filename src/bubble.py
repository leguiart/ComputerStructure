arr=[3,5,8,6,4,2,8,9,5,1]
bandera=0
cont=0
maxi=arr[0]
while bandera!=1:
    bandera=1
    while cont<len(arr):
        if arr[cont]>=maxi:
            maxi=arr[cont]
        else:
            arr[cont-1]=arr[cont]
            arr[cont]=maxi
            bandera=0
        cont+=1
    print arr
    cont=0
    maxi=arr[0]
    
print arr
