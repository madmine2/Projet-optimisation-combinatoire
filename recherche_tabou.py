from utils import *
from random import randint
import time

def recherche_tabou(cost_ring, cost_star, ring, star_matrice, star, len_list_tabou, temps, nbr_voisinage):
  best_ring     = ring.copy()
  best_star_mat = star_matrice.copy()
  best_star     = star.copy()
  best_valeur   = cout_total(cost_ring, cost_star, best_ring, best_star_mat)
  tabou         = []
  t             = 0
  start         = time.time()
  tabou.append(ring.copy())


  while temps > t:
    voisinage = {}  # dict avec key = cout & value = [ring, star_matrice, star]
    new_val = float('inf')
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

    # TODO faire une fonction qui ne joue que sur le ring pour diminuer le cout_ring (faire un TSP)
    """choix du meilleur voisin"""
    voisinage_trie = sorted(voisinage.items(), key=lambda x: x[0])  # trie du dict selon la clé (cout_total)
    out = False
    for i, new_sol in enumerate(voisinage_trie):
      if new_sol[1][0] not in tabou:  # si le ring n'est pas dans le tabou
        new_ring       = voisinage_trie[i][1][0]
        new_star_mat   = voisinage_trie[i][1][1]
        new_star       = voisinage_trie[i][1][2]
        new_val        = cout_total(cost_ring, cost_star, new_ring, new_star_mat)
        out            = True
        tabou.append(new_ring.copy())
      if out:
        break
    """gestion de la liste tabou et update des valeurs"""
    if len(tabou) > len_list_tabou:
      tabou.pop(0)

    if new_val < best_valeur:
      best_ring     = new_ring
      best_star_mat = new_star_mat
      best_star     = new_star
      best_valeur   = new_val
      print(best_valeur)
    end = time.time()
    t   = int(end - start)
  print(f"fini, best val = {best_valeur}")
  return best_ring, best_star_mat, best_star