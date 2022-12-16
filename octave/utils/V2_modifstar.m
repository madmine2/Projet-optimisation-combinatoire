
% choisis un étoile au hasard et la modifie 

function [best_ring,best_star_mat,best_star]=V2_modifstar(cost_ring,cost_star,listering,listestar,star)
  
  N=length(listering);
  num=randi(N);
  
  best_ring=listering;
  best_star=star;
  best_star_mat=listestar;
  best_valeur=Inf;
  % ajout 
  centre_star=listering(num);
  elem_star=extrait_star(centre_star,listestar);
  
  for i=elem_star
       % ajout devant
      new_listering=[listering(1:num-1),i,listering(num:end)];
      idx_star=find(star==i);
      new_star=star;
      new_star(idx_star)=[];
      newlistestar= assignement (new_star,cost_star,new_listering);
      new_val=cout (cost_ring,cost_star,new_listering,newlistestar);
      if new_val<best_valeur
        disp("ajout devant")
        best_ring=new_listering;
        best_star=new_star;
        best_star_mat=newlistestar;
        best_valeur=new_val;
      endif
      % ajout derrière
      new_listering=[listering(1:num),i,listering(num+1:end)];
      new_star=star;
      idx_star=find(star==i);
      new_star(idx_star)=[];
      newlistestar= assignement (new_star,cost_star,new_listering);
      new_val=cout (cost_ring,cost_star,new_listering,newlistestar);
      if new_val<best_valeur
         disp("ajout derrière")
        best_ring=new_listering;
        best_star=new_star;
        best_star_mat=newlistestar;
        best_valeur=new_val;
      endif
      new_listering=listering;
      new_listering(N)=i;
      new_star=star;
      idx_star=find(star==i);
      new_star(idx_star)=[];
      new_star(end+1)=centre_star;
      newlistestar= assignement (new_star,cost_star,new_listering);
      new_val=cout (cost_ring,cost_star,new_listering,newlistestar);
      if new_val<best_valeur
        disp("echange")
        best_ring=new_listering;
        best_star=new_star;
        best_star_mat=newlistestar;
        best_valeur=new_val;
      endif
    
  endfor
  
  % supression 
  new_listering=listering;
  new_listering(num)=[];
  new_star=star;
  new_star(end+1)=centre_star;
  newlistestar= assignement (new_star,cost_star,new_listering);
  new_val=cout (cost_ring,cost_star,new_listering,newlistestar);
      if new_val<best_valeur
         disp("suppression")
        best_ring=new_listering;
        best_star=new_star;
        best_star_mat=newlistestar;
        best_valeur=new_val;
      endif


endfunction
