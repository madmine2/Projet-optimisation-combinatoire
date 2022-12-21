

function [ring]=TSP_recuit(ring,cost_ring)
  N=length(ring);
  t=0;
  tic;
  % paramètre du recuit simulé 
  pi=0.8;
  pallier= N^(1.5);
  facteurT=0.95
  % recherche de la température
  ecart_type=0;
  for i=ring
    ecart_type+=std(cost_ring(ring,i));
  endfor
 
  disp('ecart_type'),disp(ecart_type);
  Ti=-ecart_type/log(pi);
  T=Ti
  best_ring=ring ;
  valeur=cout_ring(ring,cost_ring);
  best_valeur=valeur;
  
  while t<3*60
   
    itt=1;
    fige=true;
    while t<3*60 && itt<=pallier
       % mouvement aléatoire
      i=randi([2,length(ring)]);
      do
        j=randi([2,length(ring)]);
      until j!=i
       [new_ring ]=V1_permut(ring,i,j);
       
       % Evaluation si changement  
       new_valeur=cout_ring(new_ring,cost_ring);
       if new_valeur<=valeur
         % on garde le changement 
         ring=new_ring;
         valeur=new_valeur;
         fige=false;
       else
         deltaE=new_valeur-valeur;
         p=exp(-deltaE/T);
         nbre=rand();
         if nbre<=p % on garde le changement 
           ring=new_ring;
           valeur=new_valeur;
           fige=false;
         endif
               
       endif
       
       %mise à jour de la nouvelle meilleure valeur 
       if new_valeur<best_valeur
         best_ring=new_ring ;
         best_valeur=new_valeur
         
       endif
      
      t=toc;
      itt+=1;
    endwhile
    
    if fige==true
      break;
    else
       T=T*facteurT;
    endif
  endwhile
  
  display(t)
  

endfunction
