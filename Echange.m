

function [new_listering,newlistestar,new_star]=V2_modifstar(cost_ring,cost_star,listering,listestar,star)
  
  N=length(star);
  num=randi(N);
  elem_star=star(num);
  centre_star=find(listestar(elem_star,:)==1);
  idx_centre=find(listering==centre_star);
  new_listering=listering;
  new_listering(idx_centre)=elem_star;
  new_star=star;

  new_star(num)=[];
  new_star(end+1)=centre_star;
  newlistestar= assignement (new_star,cost_star,new_listering);

endfunction
