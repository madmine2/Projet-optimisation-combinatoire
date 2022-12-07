function [best_ring,best_star_mat,best_star] = recherche_tabou(cost_ring,cost_star,ring ,star_matrice,star, len_list_tabou)
  best_ring=ring;
  best_star=star;
  best_star_mat=star_matrice;
  best_valeur=cout(cost_ring,cost_star,best_ring,best_star_mat);
  best_local_valeur=best_valeur;
  list_tabou = cell(len_list_tabou, 1);
  idx_tab = 1;
  list_tabou{idx_tab, 1} = best_ring;
  idx_tab = idx_tab + 1;
  is_tabou = false;
  is_full = false;
  t=0;
  k=1;
  % NB : pour l'instant je ne fais qu'un seul mvt sur le voisinage
  while t < 3*60
    disp(length(star));
    % choix nouveau voisinage
    Verif(best_ring,best_star_mat,best_star);
    if mod(k,4)==0 || mod(k,4)==1
      [ring, star_matrice, star]=Ajout(cost_ring, cost_star, best_ring, best_star_mat, best_star);
    elseif mod(k,4)==2
      [ring, star_matrice, star]=Echange(cost_ring, cost_star, best_ring, best_star_mat, best_star);
    else
      [ring, star_matrice, star]=Supression(cost_ring, cost_star, best_ring, best_star_mat, best_star);
    endif

    % est-ce que ring est dans la list tabou
    for i = 1:len_list_tabou
      if isequal(list_tabou{idx_tab,1}, ring)
        is_tabou = true;
      endif
    endfor

    if is_tabou == false
      % calcule du cout du nouveau voisinage
      cout = cout(cost_ring,cost_star,ring,star_matrice);
      if cout < best_valeur % update des variables si ameliorations du cout
        best_valeur = cout;
        best_ring = ring;
        best_star = star;
        best_star_mat = star_matrice;
        list_tabou{idx_tab, 1} = best_ring;
        if idx_tab < len_list_tabou
          idx_tab = idx_tab + 1;
        else
          idx_tab = 1  % re-initialisation de idx_tab
        endif
      endif
    endif

    % re-initialisation de is_tabou
    is_tabou = false;

    % suppression du premier element de list_tabou si elle est pleine
    if is_full == true
      for i = 1:len_list_tabou - 1
        list_tabou{i, 1} = list_tabou{i + 1, 1};  % suppression du premier element de list_tabou (en l_ecrasant)
      endfor
    endif
    k = k + 1;
  endwhile
endfunction
