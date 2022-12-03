
% choisis un �toile au hasard et la modifie 

function [best_ring,best_star_mat,best_star]=V2_modifstar(cost_ring,cost_star,listering,listestar,star)
  
  N=length(listering);
  num=randi(N);
  
  best_ring=listering;
  best_star=star;
  best_star_mat=listestar;
  best_valeur=cout (cost_ring,cost_star,best_ring,best_star_mat);
  % ajout 
  centre_star=listering(N);
  elem_star=extrait_star(centre_star,listestar);
  
  for i=elem_star
      % ajout devant
      new_listering=[listering(1:centre_star-1),i,listering(centre_star:end)];
      new_star=star;
      new_star(i)=[];
      newlistestar= assignement (new_star,cost_star,new_listering);
      new_val=cout (cost_ring,cost_star,new_listering,newlistestar);
      if new_val<best_valeur
        best_ring=new_listering;
        best_star=new_star;
        best_star_mat=newlistestar;
        best_valeur=new_val;
      endif
      % ajout derri�re
      new_listering=[listering(1:centre_star),i,listering(centre_star+1:end)];
      new_star=star;
      new_star(i)=[];
      newlistestar= assignement (new_star,cost_star,new_listering);
      new_val=cout (cost_ring,cost_star,new_listering,newlistestar);
      if new_val<best_valeur
        best_ring=new_listering;
        best_star=new_star;
        best_star_mat=newlistestar;
        best_valeur=new_val;
      endif
      % echange 
      new_listering=listering;
      new_listering(N)=i;
      new_star=star;
      new_star(end+1)=centre_star;
      newlistestar= assignement (new_star,cost_star,new_listering);
      new_val=cout (cost_ring,cost_star,new_listering,newlistestar);
      if new_val<best_valeur
        best_ring=new_listering;
        best_star=new_star;
        best_star_mat=newlistestar;
        best_valeur=new_val;
      endif
    
  endfor
  
  % supression 
  new_listering=listering;
  new_listering(N)=[];
  new_star=star;
  new_star(end+1)=centre_star;
  newlistestar= assignement (new_star,cost_star,new_listering);
  new_val=cout (cost_ring,cost_star,new_listering,newlistestar);
      if new_val<best_valeur
        best_ring=new_listering;
        best_star=new_star;
        best_star_mat=newlistestar;
        best_valeur=new_val;
      endif


endfunction
