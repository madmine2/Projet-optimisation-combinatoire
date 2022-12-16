import utils
import main

cost_ring, cost_star = main.read_instances(fileName = "instances/instance1.txt")  # GOOD

ring, star_matrice, star = utils.ini_min_somme(cost_ring, cost_star)  # GOOD

utils.verif(ring, star_matrice, star, len(cost_ring))  # GOOD

cout_total = utils.cout_total(cost_ring, cost_star, ring, star_matrice)


