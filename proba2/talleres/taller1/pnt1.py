import numpy as np 

a = np.matrix('0.12 0.15 0.1; 0.17 0.08 0.13; 0.05 0.14 0.06')
x = [0, 2, 4]
y = [1, 3, 5]

def px(a):

    probs = np.sum(a, axis=0) 
    return probs

def py(a):

    probs = np.sum(a, axis=1) 
    return probs

def f(x, y):
    
    return (x**2)*y

def expected(f, a, x, y):

    suma = 0
    xindx = 0
    yindx = 0
    
    for i in x: 
        for j in y: 
            suma += f(i, j) * a[xindx, yindx]
            yindx += 1

        xindx += 1
        yindx = 0

    print("valor esperado es: ", suma)

print("probabilidad de x: ", px(a))
print("probabilidad de y: ")
print(py(a))

expected(f, a, x, y)


