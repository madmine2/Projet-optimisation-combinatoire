

function [best_ring,best_star_mat,best_star] = Ajout (cost_ring,cost_star,listering,listestar,star)
  disp("ajout devant")
  N=length(star);
  num=randi(N);
  elem_star=star(num);
  % ajout 
  listering(end+1)=elem_star;
  star(num)=[];
  listestar= assignement (star,cost_star,listering);
  
  best_ring=listering;
  best_star=star;
  best_star_mat=listestar;
  best_valeur=cout_ring(listering,cost_ring);

% on conserve la meilleure listering 
  for i=1:length(listering)-1
      [new_listering]=V1_permut(listering,i,length(listering));
      
      
      new_val=cout (cost_ring,cost_star,new_listering,listestar);
      if new_val<best_valeur
     
        best_ring=new_listering;
        best_valeur=new_val;
      endif
     
      
    endfor
    
endfunction
