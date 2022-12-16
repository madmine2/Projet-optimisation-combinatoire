def recherche_tabou(cost_ring, cost_star, ring, star_matrice, star, len_list_tabou):
  best_ring = ring
  best_star = star
  best_star_mat = star_matrice
  best_valeur = cout(cost_ring, cost_star, best_ring, best_star_mat)
  best_local_valeur = best_valeur
  list_tabou = [None] * len_list_tabou
  idx_tab = 1
  list_tabou[idx_tab - 1] = best_ring
  idx_tab += 1
  is_tabou = False
  is_full = False
  t = 0
  k = 1
  # NB : pour l'instant je ne fais qu'un seul mvt sur le voisinage
  while t < 3*60:
    print(len(star))
    # choix nouveau voisinage
    Verif(best_ring, best_star_mat, best_star)
    if k % 4 == 0 or k % 4 == 1:
      ring, star_matrice, star = Ajout(cost_ring, cost_star, best_ring, best_star_mat, best_star)
    elif k % 4 == 2:
      ring, star_matrice, star = Echange(cost_ring, cost_star, best_ring, best_star_mat, best_star)
    else:
      ring, star_matrice, star = Supression(cost_ring, cost_star, best_ring, best_star_mat, best_star)

    # est-ce que ring est dans la list tabou
    for i in range(len_list_tabou):
      if list_tabou[idx_tab - 1] == ring:
        is_tabou = True

    if not is_tabou:
      # calcule du cout du nouveau voisinage
      val = cout(cost_ring, cost_star, ring, star_matrice)
      if val < best_valeur: # update des variables si ameliorations du cout
        best_valeur = val
        best_ring = ring
        best_star = star
        best_star_mat = star_matrice
        list_tabou[idx_tab - 1] = best_ring
        if idx_tab < len_list_tabou:
          idx_tab += 1
        else:
          idx_tab = 1  # re-initialisation de idx_tab

    # re-initialisation de is_tabou
    is_tabou = False

    # suppression du premier element de list_tabou si elle est pleine
    if is_full:
      for i in range(len_list_tabou - 1):
        list_tabou[i] = list_tabou[i + 1]  # suppression du premier element de list_tabou (en l_ecrasant)

    k += 1
    print(best_valeur)
