function [best_ring,best_star_mat,best_star,best_valeur]=Meilleur_Echange(cost_ring,cost_star,ring,star_matrice,star)

  best_ring=ring ;
  best_star=star;
  best_star_mat=star_matrice;
  best_valeur=Inf;
  

  
  for i=1:length(ring)
    for j=1:length(star)
      
    
      
      
        elem_star=star(j);
        new_ring =ring ;
        new_ring (i)=elem_star;
        new_star=star;
        new_star(j)=[];
        new_star(end+1)=ring(i);
        newstar_matrice= assignement (new_star,cost_star,new_ring );
        new_val=cout (cost_ring,cost_star,new_ring ,newstar_matrice);
        
        if new_val<best_valeur
           
              best_ring=new_ring ;
              best_star=new_star;
              best_star_mat=newstar_matrice;
              best_valeur=new_val;
        endif 
            

      endfor 
   endfor
    
    
endfunction
