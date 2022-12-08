# Echange entre un élément star choisit aléatoirement avec l'élément ring auquel il était assigné 

function [new_ring ,newstar_matrice,new_star]=Echange(cost_ring,cost_star,ring ,star_matrice,star)
  
  N=length(star);
  num=randi(N);
  elem_star=star(num);
  centre_star=find(star_matrice(elem_star,:)==1);
  idx_centre=find(ring ==centre_star);
  new_ring =ring ;
  new_ring (idx_centre)=elem_star;
  new_star=star;

  new_star(num)=[];
  new_star(end+1)=centre_star;
  newstar_matrice= assignement (new_star,cost_star,new_ring );

endfunction
