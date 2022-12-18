import random
import numpy as np


# Fonction qui calcule le coût total
def cout_total(cost_ring, cost_star, ring, star_matrice):
    cout_ring = 0
    cout_star = 0

    # cout du ring
    if len(ring) > 0:
        for i in range(len(ring) - 1):
            cout_ring += cost_ring[ring[i]][ring[i + 1]]
        cout_ring += cost_ring[ring[0]][ring[-1]]

    # cout des stars
    for i in range(len(cost_star)):
        for j in range(len(cost_star)):
            if star_matrice[i, j] == 1:
                cout_star += cost_star[i][j]

    return cout_star + cout_ring


# Fonction qui calcule le coût du ring
def cout_ring(ring, cost_ring):
    # Coût du ring
    cout = 0
    for i in range(len(ring) - 1):
        cout += cost_ring[ring[i + 1]][ring[i]]
    cout += cost_ring[ring[0]][ring[-1]]

    return cout


def ajout(cost_ring, cost_star, ring, star_matrice, star):
    if len(ring) == len(cost_ring):  # je ne peux plus rien ajouter dans le ring
        return ring, star_matrice, star
    # print("Ajout dans ring")
    num = random.randint(0, len(star) - 1)
    elem_star = star[num]
    ring.append(elem_star)  # ajout dans le ring
    star.pop(num)  # suppression dans le star
    star_matrice = assignement(star, cost_star, ring)

    """ on fait des permutations afin de conserver le meilleur ring"""
    best_ring = ring
    best_star = star
    best_star_mat = star_matrice
    best_valeur = cout_ring(ring, cost_ring)

    for i in range(len(ring)):
        new_ring = v1_permut(ring, i, len(ring) - 1)
        new_val = cout_total(cost_ring, cost_star, new_ring, star_matrice)
        if new_val < best_valeur:
            best_ring = new_ring
            best_valeur = new_val

    return best_ring, best_star_mat, best_star


def extrait_star(centre_star, listestar):
    elem_star = []
    for i in range(len(listestar)):
        if listestar[i, centre_star] == 1:
            elem_star.append(i)
    return elem_star


def assignement(star, cost_star, ring):
    N = len(cost_star)
    star_matrice = np.zeros((N, N))
    for i in star:
        temp = np.array(cost_star[i])  # utilisation de numpy array car plus rapide en calcule
        temp[i] = 1e10  # je mets l'élément diag très grand pour ne pas le considérer comme le min (np.inf pas utilisable car temp = int array)
        idx = temp.argmin()
        star_matrice[i, idx] = 1

    return star_matrice


def permut(ring, num1, num2):
    ring[num1], ring[num2] = ring[num2], ring[num1]
    return ring


def echange(cost_ring, cost_star, ring, star_matrice, star):  # FIXME marche pas
    num = random.randint(0, len(star) - 1)
    elem_star = star[num]
    centre_star = np.where(star_matrice[elem_star, :] == 1)
    idx_centre = np.where(ring == centre_star)
    new_ring = ring
    new_ring[idx_centre] = elem_star
    new_star = star
    new_star.pop(num)
    new_star.append(centre_star)
    newstar_matrice = assignement(new_star, cost_star, new_ring)

    return new_ring, newstar_matrice, new_star


def ini_min_somme(cost_ring, cost_star):
    N = len(cost_ring)
    ring = []
    star = []
    for i in range(N):
        if random.random() < 0.5:
            ring.append(i)
        else:
            star.append(i)

    star_matrice = assignement(star, cost_star, ring)

    return ring, star_matrice, star


def supression(cost_ring, cost_star, ring, star_matrice, star):
    # print("Suppression dans le ring")
    if len(ring) == 0:  # si ring vide
        return ring, star_matrice, star
    num = random.randint(0, len(ring) - 1)
    val = ring[num]
    ring.pop(num)
    star.append(val)
    star_matrice = assignement(star, cost_star, ring)

    return ring, star_matrice, star


def verif(ring, star_matrice, star, M):
    N = len(star_matrice)
    if N != M:
        print("La star matrice n'a pas la bonne taille")
    if len(ring) + len(star) != M:
        print("star et ring n ont pas la bonne taille")

    for i in range(N):
        if i in ring:
            if i in star:
                print("Cet élément est dans le ring et star"), print(i)
            else:
                if not (star_matrice[i, :] == np.zeros(N)).all:
                    print("la ligne de la matrice n'est pas correcte"), print(i)
        elif len(np.where(ring == i)[0]) > 1:
            print("Cet élément est plusieus fois dans ring"), print(i)
        elif len(np.where(star == i)[0]) > 1:
            print("Cet élément est plusieus fois dans star"), print(i)
        elif i in star:
            if len(np.where(star_matrice[i, :] == 1)[0]) > 0:
                idx = np.where(star_matrice[i, :] == 1)[0]
                if idx in ring:
                    continue
                else:
                    print("pas attribué à un ring"), print(i)
            else:
                print("l'élément n'est pas attribué"), print(i)
        else:
            print("Il manque l'élément"), print(i)
