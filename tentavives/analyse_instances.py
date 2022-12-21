import numpy as np

"""fichier ayant pour but d'analyser les couts des rings et des stars"""

def read_instances(fileName):
    with open(fileName,'r') as fin :
        N = int(fin.readline())
        cost_ring = []
        cost_star = []
        for i in range(N) :
            _ = fin.read(1) # pour enlever le premier caractére qui est un espace
            cost_ring.append([int(a) for a in fin.readline().rstrip().split(" ")])

        for i in range(N):
            _ = fin.read(1)  # pour enlever le premier caractére qui est un espace
            cost_star.append([int(a) for a in fin.readline().rstrip().split(" ")])
    return cost_ring, cost_star


fileNames = ['instances/instance1.txt', 'instances/instance2.txt', 'instances/instance3.txt', 'instances/instance4.txt', 'instances/instance5.txt',
            'instances/instance6.txt', 'instances/instance7.txt', 'instances/instance8.txt', 'instances/instance9.txt']

for fileName in fileNames:
    cost_ring, cost_star = read_instances(fileName)
    N = len(cost_ring)
    cost_ring = np.array(cost_ring)
    cost_star = np.array(cost_star)
    count = 0  # nombre de fois que le cout du ring est inférieur à celui du star
    for i in range(N):
        for j in range(N):
            if cost_ring[i, j] <= cost_star[i, j]:
                count += 1
    ringVSstar = count/(N*N)  # ratio du nombre de fois ou un cout dans le ring est inférieur à un cout dans le star
    print(f"{fileName} : \nringVSstar = {ringVSstar * 100}\nstarVSring = {(1 - ringVSstar) * 100}\n")

"""après exécution, les fichiers 1, 4, 7 ont tous les coûts du ring inférieur à ceux du star, ce qui concorde avec le fait que les sol avec 100% de ring sont les meilleurs"""