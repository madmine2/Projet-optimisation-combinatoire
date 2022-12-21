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