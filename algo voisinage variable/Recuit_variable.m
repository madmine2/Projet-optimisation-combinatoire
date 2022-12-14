function [best_ring,best_star_mat,best_star]=Recuit_variable(cost_ring,cost_star,ring ,star_matrice,star)
  % initialisation 
  tic;
  N=length(star_matrice);
  best_ring=ring ;
  best_star=star;
  best_star_mat=star_matrice;
  valeur=cout(cost_ring,cost_star,best_ring,best_star_mat);
  best_valeur=valeur;
  t=0;
  itt=1;
  N=length(cost_ring);
  t=0;
  tic;
  % paramètre du recuit simulé 
  pi=0.8;
  pallier= N^(1.5);
  facteurT=0.9;
  % recherche de la température
  ecart_type=0;
  for i=ring
    ecart_type+=std(cost_ring(ring,i));
  endfor
  ecart_type/length(ring);
  Ti=-ecart_type/log(pi);
  T=Ti;


  
  while t<3*60
   
    itt=1;
    fige=true;
    while t<3*60 && itt<=pallier
      
      k=randi(3)+1;
      
      if mod(k,4)==0 
        disp('a')
        [new_ring ,new_star_matrice,new_star,new_valeur]=Meilleur_Ajout(cost_ring,cost_star,ring,star_matrice,star);
        Verif(new_ring ,new_star_matrice,new_star)
       
       elseif mod(k,4)==1
        disp('p')
        [new_ring ,new_star_matrice,new_star,new_valeur]=Meilleur_Permutation(cost_ring,cost_star,ring,star_matrice,star);
        Verif(new_ring ,new_star_matrice,new_star)
       elseif mod(k,4)==2 
        disp('e')
        [new_ring ,new_star_matrice,new_star,new_valeur]=Meilleur_Echange(cost_ring,cost_star,ring,star_matrice,star);
        Verif(new_ring ,new_star_matrice,new_star)
       else
        disp('s')
         [new_ring ,new_star_matrice,new_star,new_valeur]=Meilleur_Supression(cost_ring,cost_star,ring,star_matrice,star);
         Verif(new_ring ,new_star_matrice,new_star)
      
       endif
       
       % Evaluation si changement  
      
       if new_valeur<=valeur 
         % on garde le changement 
         ring=new_ring;
         valeur=new_valeur;
         star=new_star;
         star_matrice=new_star_matrice;
         
         fige=false;
       else
         deltaE=new_valeur-valeur;
         p=exp(-deltaE/T);
         nbre=rand();
         if nbre<=p % on garde le changement 
           ring=new_ring;
           valeur=new_valeur;
           star=new_star;
           star_matrice=new_star_matrice;
           fige=false;
         endif
               
       endif
       
       %mise à jour de la nouvelle meilleure valeur 
       if new_valeur<best_valeur
         best_ring=new_ring ;
         best_valeur=new_valeur
         best_star=new_star;
         best_star_mat=new_star_matrice;
         disp(length(ring));
         
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