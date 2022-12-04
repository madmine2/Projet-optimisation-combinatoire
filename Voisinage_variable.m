

function [best_ring,best_star_mat,best_star]=Voisinage_variable(cost_ring,cost_star,listering,listestar,star)
  % initialisation 
  tic;
  best_ring=listering;
  best_local_ring=listering;
  best_star=star;
  best_local_star=star;
  best_star_mat=listestar;
  best_local_star_mat=listestar;
  best_valeur=cout(cost_ring,cost_star,best_ring,best_star_mat);
  best_local_valeur=best_valeur;
  t=0;
  k=1;
  while t < 3*60
   disp(length(star))
   Verif(best_local_ring,best_local_star_mat,best_local_star)
   if mod(k,4)==0 || mod(k,4)==1 
    %diversification  
   
     
      [listering,listestar,star]=Ajout(cost_ring,cost_star,best_local_ring,best_local_star_mat,best_local_star);
      
     elseif mod(k,4)==2 
       [listering,listestar,star]=Echange(cost_ring,cost_star,best_local_ring,best_local_star_mat,best_local_star);
     else
        [listering,listestar,star]=Supression(cost_ring,cost_star,best_local_ring,best_local_star_mat,best_local_star);
     endif
 
      % recherche locale parmis les permutations du ring 
      for i=1:length(listering)
        for j=1:length(listering)
          if j!=i
            [new_listering]=V1_permut(listering,i,j);
             % mise à jour 
             value=cout(cost_ring,cost_star,new_listering,listestar);
             if value<best_local_valeur
               best_local_ring=new_listering;
               best_local_star=star;
               best_local_star_mat=listestar;
               best_local_valeur=value;
             endif
           endif
           
        endfor
       endfor 
       
       % mise à jour meilleures solutions :
       if best_local_valeur<best_valeur
               best_ring=best_local_ring;
               best_star= best_local_star;
               best_star_mat= best_local_star_mat;
               best_valeur= best_local_valeur
       endif
       
        
        
       
      
   t=toc ;
   k+=1;  
  endwhile
  

endfunction
