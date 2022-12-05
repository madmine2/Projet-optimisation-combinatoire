% Supression d'un élément du ring choisi aléatoirement 

function [best_ring,best_star_mat,best_star]=Supression(cost_ring,cost_star,ring ,star_matrice,star)
  N=length(ring );
  num=randi(N);
  
  best_ring=ring ;
  best_star=star;
  best_star_mat=star_matrice;
  best_valeur=Inf;
  centre_star=ring (num);
  elem_star=extrait_star(centre_star,star_matrice);
  
  % supression 
  new_ring =ring ;
  new_ring (num)=[];
  new_star=star;
  new_star(end+1)=centre_star;
  newstar_matrice= assignement (new_star,cost_star,new_ring );
  new_val=cout (cost_ring,cost_star,new_ring ,newstar_matrice);
      if new_val<best_valeur
         disp("suppression")
        best_ring=new_ring ;
        best_star=new_star;
        best_star_mat=newstar_matrice;
        best_valeur=new_val;
      endif
endfunction
