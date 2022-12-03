

function [best_ring,best_star_mat,best_star]=Voisinage_variable(cost_ring,cost_star,listering,listestar,star)
  % initialisation 
  tic;
  best_ring=listering;
  best_star=star;
  best_star_mat=listestar;
  best_valeur=cout(cost_ring,cost_star,best_ring,best_star_mat);
  t=0;
  k=1;
  while t < 3*60
    tic;
    %intensification 
    if mod(k,2)==0
      [listering]=V1_permut(best_ring );
      
    %diversification 

    else
    
      [listering,listestar,star]=V2_modifstar(cost_ring,cost_star,best_ring,best_star_mat,star);
      
      
    endif
      % recherche locale 
     
      % mise à jour 
      value=cout(cost_ring,cost_star,listering,listestar);
      if value<best_valeur
         best_ring=listering;
         best_star=star;
         best_star_mat=listestar;
         best_valeur=value
      
      endif
      
   t=toc ;
   k+=1;  
  endwhile
  

endfunction
