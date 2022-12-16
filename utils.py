import random
import numpy as np


# Fonction qui calcule le coût total
def cout_total(cost_ring, cost_star, ring, star_matrice):
    cout_ring = 0
    cout_star = 0

    # cout du ring
    for i in range(len(ring)):
        cout_ring += cost_ring[ring[i]][ring[i - 1]]
    cout_ring += cost_ring[ring[0]][ring[-1]]

    # cout des stars
    for i in range(len(cost_ring)):
        for j in ring:
            if star_matrice[i, j] == 1:
                cout_star += cost_star[j][i]

    cout_total = cout_star + cout_ring
    return cout_total
    # Coût du ring
    for i in range(len(ring) - 1):
        cout_ring += cost_ring[ring[i + 1]][ring[i]]
    cout_ring += cost_ring[ring[0]][ring[-1]]

    # Coût des stars
    for i in range(len(cost_ring)):
        for j in ring:
            if star_matrice[i, j] == 1:
                cout_star += cost_star[j][i]

    return cout_star + cout_ring


# Fonction qui calcule le coût du ring
def cout_ring(ring, cost_ring):
    # Coût du ring
    cout = 0
    for i in range(len(ring) - 1):
        cout += cost_ring[ring[i + 1], ring[i]]
    cout += cost_ring[ring[0], ring[-1]]

    return cout


def ajout(cost_ring, cost_star, ring, star_matrice, star):
    if len(ring) == len(star_matrice):
        return ring, star_matrice, star
    print("ajout")
    N = len(star)
    num = random.randint(1, N)
    elem_star = star[num - 1]
    # ajout
    ring.append(elem_star)
    del star[num - 1]
    star_matrice = assignement(star, cost_star, ring)

    best_ring = ring
    best_star = star
    best_star_mat = star_matrice
    best_valeur = cout_ring(ring, cost_ring)

    # on conserve la meilleure ring
    for i in range(len(ring) - 1):
        new_ring = v1_permut(ring, i, len(ring))

        new_val = cout(cost_ring, cost_star, new_ring, star_matrice)
        if new_val < best_valeur:
            best_ring = new_ring
            best_valeur = new_val

    return best_ring, best_star_mat, best_star


def extrait_star(centre_star, listestar):
    elem_star = []
    N = len(listestar)
    for i in range(1, N + 1):
        if listestar[i, centre_star] == 1:
            elem_star.append(i)
    return elem_star


def assignement(star, cost_star, ring):
    N = len(cost_star)

    star_matrice = np.zeros((N, N))
    for i in star:
        minval, idx = min(enumerate(cost_star[i]), key=lambda x: x[1])
        star_matrice[i, ring[idx]] = 1

    return star_matrice


def v1_permut(ring, num1, num2):
    temp = ring[num1]
    ring[num1] = ring[num2]
    ring[num2] = temp

    return ring


def cout(cost_ring, cost_star, ring, star_matrice):
    cout_ring = 0
    cout_star = 0

    # cout du ring
    for i in range(len(ring)):
        cout_ring += cost_ring[ring[i]][ring[i - 1]]
    cout_ring += cost_ring[ring[0]][ring[-1]]

    # cout des stars
    for i in range(len(cost_ring)):
        for j in ring:
            if star_matrice[i, j] == 1:
                cout_star += cost_star[j][i]

    cout_total = cout_star + cout_ring
    return cout_total


def echange(cost_ring, cost_star, ring, star_matrice, star):
    N = len(star)
    num = random.randint(1, N)
    elem_star = star[num - 1]
    centre_star = np.where(star_matrice[elem_star, :] == 1)
    idx_centre = np.where(ring == centre_star)
    new_ring = ring
    new_ring[idx_centre] = elem_star
    new_star = star

    del new_star[num - 1]
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
    if len(ring) < 2:
        return ring, star_matrice, star
    N = len(ring)
    num = random.randint(1, N)

    best_ring = ring
    best_star = star
    best_star_mat = star_matrice
    best_valeur = float("inf")
    centre_star = ring[num - 1]
    elem_star = extrait_star(centre_star, star_matrice)

    # supression
    new_ring = ring
    del new_ring[num - 1]
    new_star = star
    new_star.append(centre_star)
    newstar_matrice = assignement(new_star, cost_star, new_ring)
    new_val = cout(cost_ring, cost_star, new_ring, newstar_matrice)
    if new_val < best_valeur:
        print("suppression")
        best_ring = new_ring
        best_star = new_star
        best_star_mat = newstar_matrice
        best_valeur = new_val

    return best_ring, best_star_mat, best_star


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
                if not (star_matrice[i, :] == np.zeros((1, N))).all():
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
