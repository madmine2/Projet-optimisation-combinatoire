function [best_ring,best_star_mat,best_star,best_valeur]=Meilleur_Permutation(cost_ring,cost_star,ring,star_matrice,star)

  best_ring=ring ;
  best_star=star;
  best_star_mat=star_matrice;
  best_valeur_ring=Inf;
  

  
  for i=1:length(ring)
    for j=1:length(ring)
        if i==j
          continue 
        endif
        
        new_ring=ring;
        new_ring(i)=ring(j);
        new_ring(j)=ring(i);
        new_val_ring=cout_ring(new_ring ,cost_ring);
        
        if new_val_ring<best_valeur_ring
           
              best_ring=new_ring ;
              best_valeur_ring=new_val_ring;
        endif 
            

      endfor 
   endfor
   best_valeur=cout(cost_ring,cost_star,new_ring ,star_matrice);
    
    
endfunction
