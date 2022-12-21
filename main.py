from random import randrange
import time
import numpy as np
import random
import time


def read_instances(fileName):
    with open(fileName, 'r') as fin:
        N = int(fin.readline())
        cost_ring = []
        cost_star = []
        for i in range(N):
            _ = fin.read(1)  # pour enlever le premier caractére qui est un espace
            cost_ring.append([int(a) for a in fin.readline().rstrip().split(" ")])

        for i in range(N):
            _ = fin.read(1)  # pour enlever le premier caractére qui est un espace
            cost_star.append([int(a) for a in fin.readline().rstrip().split(" ")])
    return cost_ring, cost_star, N

def ecriture(ring,cout,star_mat,nom):
    with open(nom, 'w') as fichier:
        fichier.write("RING"+" "+str(len(ring))+"\n")
        for i in ring:
            fichier.write(str(i))
            if i!=ring[-1]:
                fichier.write(" ")
            else:
                fichier.write("\n")

        fichier.write("STAR\n")
        for i in star_mat:
            fichier.write(str(i[0])+" "+str(i[1])+"\n")
        fichier.write("COST"+" "+str(cout))





def assignement(star, cost_star, ring):
    star_matrice = []
    cout_star = 0
    for i in star:
        # 1 fait toujours parti du ring
        min = cost_star[i - 1][0]
        star_chemin = [i, 1]
        for j in ring:
            if cost_star[i - 1][j - 1] < min:
                min = cost_star[i - 1][j - 1]
                star_chemin = [i, j]
        star_matrice.append(star_chemin)
        cout_star += min

    return star_matrice, cout_star


def coutduring(ring, cost_ring):
    cout_ring = 0
    for i in range(len(ring) - 1):
        cout_ring += cost_ring[ring[i] - 1][ring[i + 1] - 1]
    cout_ring += cost_ring[ring[len(ring) - 1] - 1][0]

    return cout_ring


def cout_total(cost_ring, cost_star, ring, star):
    star_mat, cout_star = assignement(star, cost_star, ring)
    cout_ring = coutduring(ring, cost_ring)
    return cout_star + cout_ring, star_mat
def recherche_local(cost_ring, cost_star, ring, star):
    # attention ne pas toucher au dépot

    best_ring = ring.copy()
    best_star = star.copy()
    best_valeur,best_mat = cout_total(cost_ring, cost_star, ring, star)
    best=True
    while best==True :
        best=False
        for i in range(len(star)):
            new_ring = ring.copy()
            new_star = star.copy()

            new_ring.append(new_star[i])
            del new_star[i]
            new_val, star_mat = cout_total(cost_ring, cost_star, new_ring, new_star)

            if new_val < best_valeur:
                best_ring = new_ring.copy()
                best_star = new_star.copy()
                best_valeur = new_val
                best = True
                if len(best_ring) + len(best_star) < 51:
                    print("erreur")
            # recherche de la meilleure place dans le ring
            for j in range(1, len(new_ring) - 1):  # ne pas déplacer le dépot
                new2_ring = new_ring.copy()
                new2_ring = permut(new2_ring, j, len(new_ring) - 1)

                new_val, star_mat = cout_total(cost_ring, cost_star, new2_ring, new_star);
                if new_val < best_valeur:
                    best_ring = new2_ring.copy()
                    best_valeur = new_val
                    best_star = new_star.copy()
                    best = True
                    if len(best_ring) + len(best_star) < 51:
                        print("erreur")

        # supression
        for i in range(1, len(ring)):
            new_ring = ring.copy()
            new_star = star.copy()

            new_star.append(new_ring[i])
            del new_ring[i]
            new_val, star_mat = cout_total(cost_ring, cost_star, new_ring, new_star)

            if new_val < best_valeur and new_ring :
                best_ring = new_ring.copy()
                best_star = new_star.copy()
                best_valeur = new_val
                best = True
                if len(best_ring) + len(best_star) < 51:
                    print("erreur")

        # echange
        for i in range(1, len(ring)):
            for j in range(len(star)):
                new_ring = ring.copy()
                new_star = star.copy()

                new_ring[i], new_star[j] = new_star[j], new_ring[i]

                new_val, star_mat = cout_total(cost_ring, cost_star, new_ring, new_star)

                if new_val < best_valeur and new_ring :
                    best_ring = new_ring.copy()
                    best_star = new_star.copy()
                    best_valeur = new_val
                    best = True
                    if len(best_ring) + len(best_star) < 51:
                        print("erreur")

        # permutation
        for i in range(1, len(ring)):
            for j in range(1, len(ring)):
                if i != j:
                    new_ring = ring.copy()
                    new_ring = permut(new_ring, i, j)
                    new_val, star_mat = cout_total(cost_ring, cost_star, new_ring, star)

                    if new_val < best_valeur and new_ring :
                        best_ring = new_ring.copy()
                        best_star = star
                        best_valeur = new_val
                        best = True
                        if len(best_ring) + len(best_star) < 51:
                            print("erreur")

    return best_ring, best_star, best_valeur


def grasp1(cost_ring, cost_star, times):
    start = time.perf_counter()
    N = len(cost_ring)
    best_ring = []
    best_star = []
    best_value = float("inf")
    bestlist = []
    best_alpha = 0
    alphabest = []
    t = 0

    while t < times:

        for alpha in np.arange(0, 0.40, 0.01):

            ring = [1]
            star = []
            possible = [i for i in range(2, N + 1)]
            p = 1

            while len(ring) + len(star) < N:
                maximum = 0
                minimum = float("inf")

                for i in possible:

                    if cost_ring[p - 1][i - 1] > maximum:
                        maximum = cost_ring[p - 1][i - 1]

                    if cost_star[p - 1][i - 1] > maximum:
                        maximum = cost_star[p - 1][i - 1]

                    if cost_ring[p - 1][i - 1] < minimum:
                        minimum = cost_ring[p - 1][i - 1]

                    if cost_star[p - 1][i - 1] < minimum:
                        minimum = cost_star[p - 1][i - 1]

                borne = minimum + (maximum - minimum) * alpha

                options = []
                itt_ring = 0

                for i in possible:
                    if cost_ring[p - 1][i - 1] <= borne:
                        options.append(i)
                        itt_ring += 1

                for i in possible:
                    if cost_star[p - 1][i - 1] <= borne:
                        options.append(i)

                if len(options) > 1:
                    r = randrange(len(options))
                else:
                    r = 0

                for j, i in enumerate(possible):
                    if i == options[r]:
                        del possible[j]

                if r < itt_ring:
                    ring.append(options[r])
                    p = options[r]
                else:
                    star.append(options[r])



            star_mat, cout_star = assignement(star, cost_star, ring)
            cout_ring = coutduring(ring, cost_ring)


            if cout_ring+cout_star < best_value:
                best_alpha = alpha
                best_ring = ring
                best_star = star

                best_value = cout_star + cout_ring

        end = time.perf_counter()
        t = end - start
        alphabest.append(best_alpha)

        bestlist.append(best_value)

        print('best', min(bestlist))



    return best_ring, best_star


def permut(ring, num1, num2):
    ring[num1], ring[num2] = ring[num2], ring[num1]
    return ring


def meilleur_mouvement_tabou(cost_ring, cost_star, ring, star, tabou):
    # attention ne pas toucher au dépot

    best_ring = ring.copy()
    best_star = star.copy()
    best_valeur = float('inf')

    # ajout
    for i in range(len(star)):
        new_ring = ring.copy()
        new_star = star.copy()

        new_ring.append(new_star[i])
        del new_star[i]
        new_val, star_mat = cout_total(cost_ring, cost_star, new_ring, new_star)

        if new_val < best_valeur and new_ring not in tabou:
            best_ring = new_ring.copy()
            best_star = new_star.copy()
            best_valeur = new_val
            if len(best_ring) + len(best_star) < 51:
                print("erreur")
        # recherche de la meilleure place dans le ring
        for j in range(1, len(new_ring) - 1):  # ne pas déplacer le dépot
            new2_ring = new_ring.copy()
            new2_ring = permut(new2_ring, j, len(new_ring) - 1)

            new_val, star_mat = cout_total(cost_ring, cost_star, new2_ring, new_star);
            if new_val < best_valeur and new2_ring not in tabou:
                best_ring = new2_ring.copy()
                best_valeur = new_val
                best_star = new_star.copy()
                if len(best_ring) + len(best_star) < 51:
                    print("erreur")

    # supression
    for i in range(1, len(ring)):
        new_ring = ring.copy()
        new_star = star.copy()

        new_star.append(new_ring[i])
        del new_ring[i]
        new_val, star_mat = cout_total(cost_ring, cost_star, new_ring, new_star)

        if new_val < best_valeur and new_ring not in tabou:
            best_ring = new_ring.copy()
            best_star = new_star.copy()
            best_valeur = new_val
            if len(best_ring) + len(best_star) < 51:
                print("erreur")

    # echange
    for i in range(1, len(ring)):
        for j in range(len(star)):
            new_ring = ring.copy()
            new_star = star.copy()

            new_ring[i], new_star[j] = new_star[j], new_ring[i]

            new_val, star_mat = cout_total(cost_ring, cost_star, new_ring, new_star)

            if new_val < best_valeur and new_ring not in tabou:
                best_ring = new_ring.copy()
                best_star = new_star.copy()
                best_valeur = new_val
                if len(best_ring) + len(best_star) < 51:
                    print("erreur")

    # permutation
    for i in range(1, len(ring)):
        for j in range(1, len(ring)):
            if i != j:
                new_ring = ring.copy()
                new_ring = permut(new_ring, i, j)
                new_val, star_mat = cout_total(cost_ring, cost_star, new_ring, star)

                if new_val < best_valeur and new_ring not in tabou:
                    best_ring = new_ring.copy()
                    best_star = star
                    best_valeur = new_val
                    if len(best_ring) + len(best_star) < 51:
                        print("erreur")

    return best_ring, best_star, best_valeur


def TSP_recuit(ring, cost_ring, temps):
    N = len(ring)
    t = 0
    start = time.perf_counter()
    # paramètre du recuit simulé
    pi = 0.9
    pallier =N**4
    facteurT = 0.9

    # recherche de la température
    ecart_type = 0
    for i in ring:
        ecart_type += np.std([cost_ring[j-1][i-1] for j in ring if j != i])

    Ti = - ecart_type / np.log(pi)
    T = Ti
    best_ring = ring
    valeur = coutduring(ring, cost_ring)
    best_valeur = valeur

    while t < temps:

        itt = 1
        fige = True
        while t < temps and itt <= pallier:
            # mouvement aléatoire
            i = randrange(1,len(ring))
            while True:
                j = randrange(1,len(ring))
                if j != i:
                    break
            new_ring = permut(ring.copy(), i, j)

            # Evaluation si changement
            new_valeur = coutduring(new_ring, cost_ring)
            if new_valeur <= valeur:
                # on garde le changement
                ring = new_ring
                valeur = new_valeur
                fige = False
            else:
                deltaE = new_valeur - valeur
                p = np.exp(-deltaE / T)
                nbre = random.random()
                if nbre <= p:  # on garde le changement
                    ring = new_ring
                    valeur = new_valeur
                    fige = False

            # mise à jour de la nouvelle meilleure valeur
            if new_valeur < best_valeur:
                best_ring = new_ring
                best_valeur = new_valeur
                print(best_valeur)

            end = time.perf_counter()
            t = end - start
            itt += 1
        if fige:
            break
        else:
            T *= facteurT

    print(t)
    return best_ring


def recherche_tabou(cost_ring, cost_star, ring, star, temps, taille):
    best_ring = ring
    best_star = star
    best_valeur, best_star_mat = cout_total(cost_ring, cost_star, best_ring, star)
    tabou = []
    t = 0
    start = time.perf_counter()
    tabou.append(best_ring)
    while t < temps:

        ring, star, cout = meilleur_mouvement_tabou(cost_ring, cost_star, ring, star, tabou)

        if cout < best_valeur:
            print('best value', best_valeur)
            best_ring = ring
            best_star = star
            best_valeur = cout

        tabou.append(ring)
        if len(tabou) > taille:
            del tabou[0]

        end = time.perf_counter()
        t = end - start

    return best_ring, best_star


#######################################################################################


fileName = 'instances/instance2.txt'
cost_ring, cost_star, N = read_instances(fileName)
num=1
nom='output/5iG2_numero'+str(num)+'.txt'


ring, star = grasp1(cost_ring, cost_star, 5)
ring, star = recherche_tabou(cost_ring, cost_star, ring, star,5, N ^ 2)
cout, star_mat = cout_total(cost_ring, cost_star, ring, star)
ecriture(ring,cout,star_mat,nom)

print(ring)
print(star)
print(len(ring)/N)
