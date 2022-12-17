from utils import *
from recherche_tabou import recherche_tabou
from grasp import grasp1
# Initialisation ----------------

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

# Solution initiale  --------------------------
fileName = 'instances/instance1.txt'
cost_ring, cost_star = read_instances(fileName)

# ring, star_matrice, star = grasp1(cost_ring, cost_star, 60)

# verif(ring, star_matrice, star, len(cost_ring))

ring, star_matrice, star = ini_min_somme(cost_ring, cost_star)

best_ring, best_star_mat, best_star = recherche_tabou(cost_ring, cost_star, ring, star_matrice, star, len_list_tabou=10, nbr_voisinage=10, temps=15)
# initialisation aleatoire

#
# # Algorithme --------------------------
#
# #ring, star_matrice, star = recuit_variable(cost_ring, cost_star, ring, star_matrice, star)
# #[ring ,star_matrice,star]=recherche_tabou(cost_ring, cost_star, ring, star_matrice, star, 10);
# #[ring ,star_matrice,star]=fourmis(cost_ring, cost_star, ring, star_matrice, star);
#
# # Verification de la solution  --------------------------
#
#verif(ring, star_matrice, star)
#
# # Calcul du Cost ----------------
#
# cout_total = cout(cost_ring, cost_star, ring, star_matrice)
#
# # Output ------------------------
#
# # faire la transition
#
# ##dlmwrite(['output/out',fileName],["RING ",mat2str(length(Listering))],delim="");
# ##dlmwrite(['output/out',fileName],Listering,delim=" ", "-append");
#
