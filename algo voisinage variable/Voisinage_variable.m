

function [best_ring,best_star_mat,best_star]=Voisinage_variable(cost_ring,cost_star,ring ,star_matrice,star)
  % initialisation 
  tic;
  N=length(star_matrice);
  best_ring=ring ;
  best_local_ring=ring ;
  best_star=star;
  best_local_star=star;
  best_star_mat=star_matrice;
  best_local_star_mat=star_matrice;
  best_valeur=cout(cost_ring,cost_star,best_ring,best_star_mat);
  best_local_valeur=best_valeur;
  t=0;
  itt=1;
  while t < 3*60
   disp('ring taille'),disp(length(best_ring))
   
    %diversification 
    if mod(itt,10)==9
     k=randi(3)+1;
     best_local_valeur=Inf ;
      if mod(k,4)==0 || mod(k,4)==1 
        for i=1:ceil(N/3)
         [best_local_ring ,best_local_star_mat,best_local_star]=Ajout(cost_ring,cost_star,best_local_ring,best_local_star_mat,best_local_star);
        end 
         
      elseif mod(k,4)==2 
         for i=1:ceil(N/3)
          [best_local_ring ,best_local_star_mat,best_local_star]=Echange(cost_ring,cost_star,best_local_ring,best_local_star_mat,best_local_star);
          end 
      else
           for i=1:ceil(N/3)
            [best_local_ring ,best_local_star_mat,best_local_star]=Supression(cost_ring,cost_star,best_local_ring,best_local_star_mat,best_local_star);
           end 
      endif
      
     
    
     
    %intensification 
    else
     k=randi(3)+1;
      if mod(k,4)==0 || mod(k,4)==1 
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
               best_local_valeur=value
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
    end  
        
        
       
   itt+=1;  
   t=toc ;
  endwhile
  

endfunction
