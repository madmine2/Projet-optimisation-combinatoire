from random import randrange
import time
import numpy as np


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

def assignement(star, cost_star, ring):

    star_matrice = []
    cout_star=0
    for i in star:
        # 1 fait toujours parti du ring
        min = cost_star[i-1][0]
        star_chemin = [i-1, 1]
        for j in ring:
            if cost_star[i-1][j-1] < min:
                min = cost_star[i-1][j-1]
                star_chemin = [i, j]
        star_matrice.append(star_chemin)
        cout_star+=min

    return star_matrice,cout_star

def coutduring(ring,cost_ring):
    cout_ring=0
    for i in range(len(ring)-1):
        cout_ring += cost_ring[ring[i]-1][ring[i + 1]-1]
    cout_ring += cost_ring[ring[len(ring)-1]-1][0]

    return cout_ring

def grasp1(cost_ring, cost_star, times):
    start = time.perf_counter()
    N = len(cost_ring)
    best_ring = []
    best_star = []
    best_value = float("inf")
    bestlist = []
    best_alpha = 0
    alphabest = []
    t=0

    while t < times:

        for alpha in np.arange(0, 0.1s, 0.01):
            print('alpha=', alpha)
            ring = [1]
            star = []
            possible = [i for i in range(1, N+1)]
            p = 1

            while len(ring) + len(star) < N:
                maximum = 0
                minimum = float("inf")

                for i in possible:

                    if cost_ring[p][i-1] > maximum:
                        maximum = cost_ring[p-1][i-1]

                    if cost_star[p][i-1] > maximum:
                        maximum = cost_star[p-1][i-1]

                    if cost_ring[p][i-1] < minimum:
                        minimum = cost_ring[p-1][i-1]

                    if cost_star[p][i-1] < minimum:
                        minimum = cost_star[p-1][i-1]

                borne = minimum + (maximum - minimum) * alpha

                options = []
                itt = -1

                for i in possible:
                    if cost_ring[p-1][i-1] <= borne:
                        options.append(i)
                        itt += 1

                for i in possible:
                    if cost_star[p-1][i-1] <= borne:
                        options.append(i)

                if len(options) > 1:
                    r = randrange(len(options))
                else:
                    r = 0

                for j, i in enumerate(possible):
                    if i == options[r]:
                        del possible[j]

                if r < itt:
                    ring.append(options[r])
                    p = options[r]
                else:
                    star.append(options[r])

            star_mat,cout_star = assignement(star, cost_star, ring)
            cout_ring=coutduring(ring, cost_ring)




            if cout_star+cout_ring < best_value:
                best_alpha = alpha
                best_ring = ring
                best_star = star
                best_star_mat = star_mat
                best_value =cout_star+cout_ring
        print('time',t)
        end = time.perf_counter()
        t = end - start
        alphabest.append(best_alpha)
        print('meilleurs alpha=', alphabest)
        bestlist.append(best_value)
        print('list_best', bestlist)
        print('best', min(bestlist))

    return best_ring,best_star








#######################################################################################


fileName = 'instances/instance1.txt'
cost_ring, cost_star = read_instances(fileName)

ring,star = grasp1(cost_ring, cost_star, 60)







