

function [best_ring,best_star_mat,best_star]=Voisinage_variable(cost_ring,cost_star,ring ,star_matrice,star)
  % initialisation 
  tic;
  best_ring=ring ;
  best_local_ring=ring ;
  best_star=star;
  best_local_star=star;
  best_star_mat=star_matrice;
  best_local_star_mat=star_matrice;
  best_valeur=cout(cost_ring,cost_star,best_ring,best_star_mat);
  best_local_valeur=best_valeur;
  t=0;
  k=1;
  while t < 3*60
   disp(length(star))
   Verif(best_local_ring,best_local_star_mat,best_local_star)
   if mod(k,4)==0 || mod(k,4)==1 
    %diversification  
   
     
      [ring ,star_matrice,star]=Ajout(cost_ring,cost_star,best_local_ring,best_local_star_mat,best_local_star);
      
     elseif mod(k,4)==2 
       [ring ,star_matrice,star]=Echange(cost_ring,cost_star,best_local_ring,best_local_star_mat,best_local_star);
     else
        [ring ,star_matrice,star]=Supression(cost_ring,cost_star,best_local_ring,best_local_star_mat,best_local_star);
     endif
 
      % recherche locale parmis les permutations du ring 
      for i=1:length(ring )
        for j=1:length(ring )
          if j!=i
            [new_ring ]=V1_permut(ring ,i,j);
             % mise à jour 
             value=cout(cost_ring,cost_star,new_ring ,star_matrice);
             if value<best_local_valeur
               best_local_ring=new_ring ;
               best_local_star=star;
               best_local_star_mat=star_matrice;
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
