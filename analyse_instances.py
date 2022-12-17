from functions_testing import ring
from main import read_instances
import numpy as np

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
    ringVSstar = count/(N*N)
    print(f"{fileName} : \nringVSstar = {ringVSstar * 100}\nstarVSring = {(1 - ringVSstar) * 100}\n")

