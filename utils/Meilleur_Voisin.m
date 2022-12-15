

function [best_ring,best_star_mat,best_star,best_value]=Meilleur_Voisin(cost_ring,cost_star,ring,star_matrice,star)
  
  best_ring=ring;
  best_star=star;
  best_star_mat=star_matrice;
  best_value=cout(cost_ring,cost_star,ring ,star_matrice);
  
  [new_ring,new_star_matrice,new_star,new_value]=Meilleur_Supression(cost_ring,cost_star,ring,star_matrice,star);
  if new_value>best_value
    disp("supression");
    best_ring=new_ring;
    best_star=new_star;
    best_star_mat=new_star_matrice;
    best_value= new_value;
  endif
  [new_ring,new_star_matrice,new_star,new_value]=Meilleur_Ajout(cost_ring,cost_star,ring,star_matrice,star);
  if new_value>best_value
    disp("Ajout");
    best_ring=new_ring;
    best_star=new_star;
    best_star_mat=new_star_matrice;
    best_value= new_value;
  endif
  [new_ring,new_star_matrice,new_star,new_value]=Meilleur_Echange(cost_ring,cost_star,ring,star_matrice,star);
  if new_value>best_value
    disp("Echange");
    best_ring=new_ring;
    best_star=new_star;
    best_star_mat=new_star_matrice;
    best_value= new_value;
  endif
  [new_ring,new_star_matrice,new_star,new_value]=Meilleur_Permutation(cost_ring,cost_star,ring,star_matrice,star);
  if new_value>best_value
    disp("Permutation");
    best_ring=new_ring;
    best_star=new_star;
    best_star_mat=new_star_matrice;
    best_value= new_value;
  endif

  

endfunction
