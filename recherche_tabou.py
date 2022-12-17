from utils import *
from random import randint
import time

def recherche_tabou(cost_ring, cost_star, ring, star_matrice, star, len_list_tabou, temps, nbr_voisinage):
  best_ring     = ring
  best_star_mat = star_matrice
  best_star     = star
  best_valeur   = cout_total(cost_ring, cost_star, best_ring, best_star_mat)
  tabou         = []
  t             = 0
  start         = time.time()

  while temps > t:
    voisinage = {}  # dict avec key = cout & value = [ring, star_matrice, star]
    """Génération du voisinage"""
    choice = randint(1, 2)
    if choice == 1:
      for _ in range(randint(1, nbr_voisinage)):
        ring, star_matrice, star = ajout(cost_ring, cost_star, ring, star_matrice, star)
        cout                     = cout_total(cost_ring, cost_star, ring, star_matrice)
        voisinage[cout]          = [ring, star_matrice, star]  # ajout du nouveau voisinage
    elif choice == 2:
      for _ in range(randint(1, nbr_voisinage)):
        ring, star_matrice, star = supression(cost_ring, cost_star, ring, star_matrice, star)
        cout                     = cout_total(cost_ring, cost_star, ring, star_matrice)
        voisinage[cout]          = [ring, star_matrice, star]

    """choix du meilleur voisin"""
    voisinage_trie = sorted(voisinage.items(), key=lambda x: x[0])  # trie du dict selon la clé (cout_total)
    new_ring       = voisinage_trie[0][1][0]
    new_star_mat   = voisinage_trie[0][1][1]
    new_star       = voisinage_trie[0][1][2]
    new_val        = cout_total(cost_ring, cost_star, new_ring, new_star_mat)

    """gestion de la liste tabou et update des valeurs"""
    tabou.append([new_ring, new_star_mat, new_star])
    if len(tabou) > len_list_tabou:
      tabou.pop(0)

    if new_val < best_valeur:
      best_ring     = new_ring
      best_star_mat = new_star_mat
      best_star     = new_star
      best_valeur   = new_val
    end = time.time()
    t   = int(end - start)
  print(f"fini, best val = {best_valeur}")
  return best_ring, best_star_mat, best_star