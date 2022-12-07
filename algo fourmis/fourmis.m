
function [best_ring,best_star_mat,best_star]=fourmis(cost_ring,cost_star,ring ,star_matrice,star)
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
 # Coeur de l'algorithme ---------------------------  
           
  nombreFourmis = 10;
  nombreLieu = length(ring);
  alpha = 2; #  Importance du pheromone (plus grand que 1) (grand alpha = plus de pheromone)
  beta = 0.5 ;# importance de la visibilite (plus petit que 1) (grand beta = plus de pheromone)
  Q = 0.5; # poids du pheromone depose (grand Q = plus de pheromone)
  omega = 0.5; # intensite de l'evaporation du pheromone (entre 0 et 1) (grand omega = moins de pheromone)
  
   # Pour chaque fourmi
   for fourmi = 1 : nombreFourmis  
     matriceTrajetsInRing = zeros(nombreLieu,nombreLieu);
     ringMelangePourTirageRandom = randperm(ring);
    # Pour chaque ville (on les prends dans un ordre aléatoire) on va choisir une autre ville pour faire le trajet en fonction des pheromone
    for i = 1 :nombreLieu
      villeI = ringMelangePourTirageRandom(i);
      probabiliteIVersJ
    endfor
   endfor
  
  
  
  
  
  
  
  
  
  
  
  
  [antPositionOnRingAtStart] = initialiseFourmis(Ring,nombreLieu);
# déplacement des fourmis
   for i = 1 : nombreLieu  
    for fourmis = 1 :nombreFourmis
      # la fourmis bouge 
    endfor
   endfor
# trouver le meilleur tour
# evaporation des phéromones 
# mise à jour des pheromones
       
       
        if value<best_local_valeur
               best_local_ring=new_ring ;
               best_local_star=star;
               best_local_star_mat=star_matrice;
               best_local_valeur=value;
             endif
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