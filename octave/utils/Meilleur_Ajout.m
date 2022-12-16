

function [best_ring,best_star_mat,best_star,best_valeur]=Meilleur_Ajout(cost_ring,cost_star,ring,star_matrice,star)
  
 
  best_ring=ring ;
  best_star=star;
  best_star_mat=star_matrice;
  best_valeur=Inf;
  
  N=length(star);
  
  for i=1:N
    % ajout 
    new_ring=ring ;
    new_ring(end+1)=star(i);
    new_star=star;
    new_star(i)=[];
    newstar_matrice= assignement (new_star,cost_star,new_ring);
    new_val=cout (cost_ring,cost_star,new_ring ,newstar_matrice);
    
    if new_val<best_valeur
       
          best_ring=new_ring ;
          best_valeur=new_val;
          best_star_mat=newstar_matrice;
          best_star=new_star;
          
    endif 
    % on conserve le meilleure ring  
    for j=1:length(new_ring)-1
        [new2_ring ]=V1_permut(new_ring ,j,length(new_ring ));
        
        
        new_val=cout (cost_ring,cost_star,new2_ring ,newstar_matrice);
        if new_val<best_valeur
       
          best_ring=new2_ring ;
          best_valeur=new_val;
          best_star_mat=newstar_matrice;
          best_star=new_star;
          
        endif
       
        
    endfor
  endfor 
    
    
endfunction
