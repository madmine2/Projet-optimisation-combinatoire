# Fonction qui ajoute un élément star choisi aléatoirement à la liste ring
# mais il cherche la meilleure position qu'il a dans le ring ( cout minimum )

function [best_ring,best_star_mat,best_star] = Ajout (cost_ring,cost_star,ring ,star_matrice,star)
  disp("ajout")
  N=length(star);
  num=randi(N);
  elem_star=star(num);
  % ajout 
  ring (end+1)=elem_star;
  star(num)=[];
  star_matrice= assignement (star,cost_star,ring );
  
  best_ring=ring ;
  best_star=star;
  best_star_mat=star_matrice;
  best_valeur=cout_ring(ring ,cost_ring);

% on conserve la meilleure ring  
  for i=1:length(ring )-1
      [new_ring ]=V1_permut(ring ,i,length(ring ));
      
      
      new_val=cout (cost_ring,cost_star,new_ring ,star_matrice);
      if new_val<best_valeur
     
        best_ring=new_ring ;
        best_valeur=new_val;
      endif
     
      
    endfor
    
endfunction
