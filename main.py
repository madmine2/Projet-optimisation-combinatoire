from grasp import *

def Recuit_variable(cost_ring, cost_star, ring, star_matrice, star):
    # initialisation
    print("recuit")
    N = len(star_matrice)
    best_ring = ring
    best_star = star
    best_star_mat = star_matrice
    valeur = cout(cost_ring, cost_star, best_ring, best_star_mat)
    best_valeur = valeur
    t = 0
    itt = 1
    N = len(cost_ring)
    t = 0

    # paramètre du recuit simulé
    pi = 0.8
    pallier = 4 * N ** 1.5
    facteurT = 0.9

    # recherche de la température
    ecart_type = 0
    for i in ring:
        ecart_type += np.std(cost_ring[ring, i])
    ecart_type /= len(ring)
    Ti = -ecart_type / np.log(pi)
    T = Ti

    while t < 60:
        itt = 1
        fige = True
        while t < 3 * 60 and itt <= pallier:
            k = np.randint(3) + 1

            if k % 4 == 0:
                print("a")
                new_ring, new_star_matrice, new_star, new_valeur = ajout(cost_ring, cost_star, ring, star_matrice, star)
            elif k % 4 == 1:
                print("p")
                #new_ring, new_star_matrice, new_star, new_valeur = permutation(cost_ring, cost_star, ring, star_matrice,star)
            elif k % 4 == 2:
                print("e")
                new_ring, new_star_matrice, new_star, new_valeur = echange(cost_ring, cost_star, ring, star_matrice,star)
            else:
                print("s")
                new_ring, new_star_matrice, new_star, new_valeur = supression(cost_ring, cost_star, ring, star_matrice,star)

            # Evaluation si changement
            if new_valeur <= valeur:
                # on garde le changement
                ring = new_ring
                valeur = new_valeur
                star = new_star
                star_matrice = new_star_matrice

                fige = False
            else:
                deltaE = new_valeur - valeur
                p = np.exp(-deltaE / T)
                nbre = random()
                if nbre <= p:  # on garde le changement
                    ring = new_ring
                    valeur = new_valeur
                    star = new_star
                    star_matrice = new_star_matrice
                    fige = False

            # mise à jour de la nouvelle meilleure valeur
            if new_valeur < best_valeur:
                best_ring = new_ring
                best_valeur = new_valeur
                best_star = new



# Initialisation ----------------

def read_instances(fileName):
    with open(fileName,'r') as fin :
        N = int(fin.readline())
        cost_ring = []
        cost_star = []
        for i in range(N) :
            b = fin.read(1) # pour enlever le premier caractére qui est un espace
            cost_ring.append([int(a) for a in fin.readline().rstrip().split(" ")])

        for i in range(N):
            b = fin.read(1)  # pour enlever le premier caractére qui est un espace
            cost_star.append([int(a) for a in fin.readline().rstrip().split(" ")])
    return cost_ring, cost_star

# Solution initiale  --------------------------
fileName = 'instances/instance1.txt'
cost_ring, cost_star = read_instances(fileName)
# initialisation aleatoire
alpha = 0.1
ring, star_matrice, star, sol = grasp1(cost_ring, cost_star, 60)
#
# # Algorithme --------------------------
#
# #ring, star_matrice, star = recuit_variable(cost_ring, cost_star, ring, star_matrice, star)
# #[ring ,star_matrice,star]=recherche_tabou(cost_ring, cost_star, ring, star_matrice, star, 10);
# #[ring ,star_matrice,star]=fourmis(cost_ring, cost_star, ring, star_matrice, star);
#
# # Verification de la solution  --------------------------
#
verif(ring, star_matrice, star)
#
# # Calcul du Cost ----------------
#
cout_total = cout(cost_ring, cost_star, ring, star_matrice)
#
# # Output ------------------------
#
# # faire la transition
#
# ##dlmwrite(['output/out',fileName],["RING ",mat2str(length(Listering))],delim="");
# ##dlmwrite(['output/out',fileName],Listering,delim=" ", "-append");
#
