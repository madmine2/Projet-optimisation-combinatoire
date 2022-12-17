from utils import *
import main

# cost_ring, cost_star = main.read_instances(fileName = "instances/instance1.txt")  # GOOD

# ring, star_matrice, star = ini_min_somme(cost_ring, cost_star)  # GOOD

ring = [2, 0]
cost_ring = [[ 0, 14, 63],
              [14,  0,  8],
              [63,  8,  0]]

star = [1]
cost_star = [[ 0,  2, 12],
              [ 2,  0, 81],
              [12, 81,  0]]

star_matrice = assignement(star, cost_star, ring)

verif(ring, star_matrice, star, len(cost_ring))  # GOOD

cout_total = cout_total(cost_ring, cost_star, ring, star_matrice)  # GOOD

best_ring, best_star_mat, best_star = ajout(cost_ring, cost_star, ring, star_matrice, star)  # GOOD

verif(best_ring, best_star_mat, best_star, len(cost_ring))  # GOOD

best_ring, best_star_mat, best_star = supression(cost_ring, cost_star, ring, star_matrice, star)  # GOOD

verif(best_ring, best_star_mat, best_star, len(cost_ring))  # GOOD

best_ring, best_star_mat, best_star = echange(cost_ring, cost_star, ring, star_matrice, star)  # TODO: tester échange

verif(ring, star_matrice, star, len(cost_ring))  # GOOD


