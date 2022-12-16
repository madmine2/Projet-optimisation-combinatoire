import utils
import main

cost_ring, cost_star = main.read_instances(fileName = "instances/instance1.txt")  # GOOD

ring, star_matrice, star = utils.ini_min_somme(cost_ring, cost_star)  # GOOD

utils.verif(ring, star_matrice, star, 51)  # GOOD





