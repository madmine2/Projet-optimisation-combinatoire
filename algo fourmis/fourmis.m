
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
  tMax = 10;                                            # nombre d'iterations de l'algo fourmis
  while t < 3*60
   disp(length(star))
   Verif(best_local_ring,best_local_star_mat,best_local_star)
   %diversification  -------------------------------------------
   if mod(k,4)==0 || mod(k,4)==1 
      [ring ,star_matrice,star]=Ajout(cost_ring,cost_star,best_local_ring,best_local_star_mat,best_local_star);
     elseif mod(k,4)==2 
       [ring ,star_matrice,star]=Echange(cost_ring,cost_star,best_local_ring,best_local_star_mat,best_local_star);
     else
        [ring ,star_matrice,star]=Supression(cost_ring,cost_star,best_local_ring,best_local_star_mat,best_local_star);
     endif
     
 # parametre de l'algo ------------------------------------------
    nombreFourmis = 5;
    nombreLieu = length(ring);
    matricePheromone = ones(nombreLieu);
    alpha = 2;                                            # Importance du pheromone (plus grand que 1) (grand alpha = plus de pheromone)
    beta = 0.5 ;                                          # importance de la visibilite (plus petit que 1) (grand beta = plus de pheromone)
    Q = 0.5;                                              # poids du pheromone depose (grand Q = plus de pheromone)
    omega = 0.5;                                          # intensite de l'evaporation du pheromone (entre 0 et 1) (grand omega = moins de pheromone)
    listeVilleEncoreDisponibles = ring;                   # toutes les villes vers lequelles la fourmis peut aller
 # Coeur de l'algorithme ----------------------------------------
 for t = 1 : tMax
    
    matriceDeltaPheromone = zeros(nombreLieu);            # represente la quantite de pheromone ajoute par les fourmis pendant l'iteration actuelle
    # Pour chaque fourmi
    for fourmi = 1 : nombreFourmis  
       listeTrajetFourmi = []        # Les trajets que fait cette fourmi
       coutTrajetFourmi = 0;                              # cout du trajet de cette fourmi
         
         # Pour chaque ville (on les prends dans un ordre aléatoire) on va choisir une autre ville pour faire le trajet en fonction des pheromone
          villeActuelle = randperm(nombreLieu,1);         # Choisi une ville au hasard pour demarrer
          for i = 1 :(nombreLieu - 1)
            villeActuelle;
            listeVilleEncoreDisponibles = listeVilleEncoreDisponibles(listeVilleEncoreDisponibles ~= villeActuelle) # permet de retirer la villeActuelle de la liste (me demande pas comment ça marche)
            [villeActuelle,listeTrajetFourmi,coutTrajetFourmi, listeVilleEncoreDisponibles] = choixDuTrajetIVersJ(ring,villeActuelle, listeTrajetFourmi,nombreLieu, matricePheromone,matriceDeltaPheromone, cost_ring, alpha, beta,coutTrajetFourmi,listeVilleEncoreDisponibles); #calcul la probabilité de choisir chaque chemin et ensuite utilise random
          endfor  
          coutTrajetFourmi += cost_ring(ring(villeActuelle), ring(listeTrajetFourmi(1)));  # Ajout du trajet de la derniere ville à la premiere pour completer le circuit
       # Deposer les pheromones
       L = coutTrajetFourmi; #longueur totale du trajet/tour de la fourmi sur cettte iteration
       deltaTau = Q / L;
       for m = 1 : nombreLieu - 1
         matriceDeltaPheromone(listeTrajetFourmi(m),listeTrajetFourmi(m+1)) += deltaTau;   # Pour chaque chemin que la fourmi emprunte elle rajoute une quantite de pheromone deltaTau
         matriceDeltaPheromone(listeTrajetFourmi(m+1),listeTrajetFourmi(m)) += deltaTau;
       endfor
        matriceDeltaPheromone(listeTrajetFourmi(0),listeTrajetFourmi(end)) += deltaTau;     # Ajout pour le trajet du dernier au premier
        matriceDeltaPheromone(listeTrajetFourmi(end),listeTrajetFourmi(0)) += deltaTau;
    endfor
    
    # Evaporation des pheromones
    for m = 1 : nombreLieu
       for n = 1 : nombreLieu
           matricePheromone(m,n) = (1- omega ) * matricePheromone(m,n) + matriceDeltaPheromone(m,n);   # Pour chaque chemin que la fourmi emprunte elle rajoute une quantite de pheromone deltaTau. Dans les notes il utilise la lettre rho alors qu'il appelle ça omega (il a copié un pdf que j'ai trouve et ces vilain garnements n'expliquaient même pas c'est quoi ce rho ou d'où il vient, ils le sortaient juste de leur cul...                                                                                                                                                                                                                                                                                                                                                       
                                                                                                                                                                                                                                                                                                                                                                              #ture et j'ai pas du tout failli me jeter par la fenetre (j'aurais pu deviner mais il est 1h du mat et j'en ai jusque là)
       endfor
    endfor
     
  endfor
  new_ring = listeTrajetFourmi
  value=cout(cost_ring,cost_star,new_ring ,star_matrice);
  # Evaluation de la solution trouve
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