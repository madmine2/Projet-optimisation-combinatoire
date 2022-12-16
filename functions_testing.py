from utils import *
import main

cost_ring, cost_star = main.read_instances(fileName = "instances/instance1.txt")  # GOOD

ring, star_matrice, star = ini_min_somme(cost_ring, cost_star)  # GOOD

verif(ring, star_matrice, star, len(cost_ring))  # GOOD

cout_total = cout_total(cost_ring, cost_star, ring, star_matrice)  # GOOD

best_ring, best_star_mat, best_star = ajout(cost_ring, cost_star, ring, star_matrice, star)  # GOOD

verif(ring, star_matrice, star, len(cost_ring))  # GOOD

best_ring, best_star_mat, best_star = supression(cost_ring, cost_star, ring, star_matrice, star)  # GOOD

verif(ring, star_matrice, star, len(cost_ring))  # GOOD

best_ring, best_star_mat, best_star = echange(cost_ring, cost_star, ring, star_matrice, star)  # GOOD

verif(ring, star_matrice, star, len(cost_ring))  # GOOD

# TODO: tester échange
