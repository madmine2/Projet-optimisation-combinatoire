function [villeActuelle,listeTrajetFourmi,coutTrajetFourmi,listeVilleEncoreDisponibles] = choixDuTrajetIVersJ(ring,villeActuelle, listeTrajetFourmi,nombreLieu, matricePheromone,matriceDeltaPheromone,cost_ring, alpha, beta,coutTrajetFourmi,listeVilleEncoreDisponibles)
  pkg load statistics;
  #pr�parations-------------------------------------------------------------
  listeProbaDuTrajetIVersJ = zeros(1,nombreLieu);
  poidsTrajetTotal = 0;
  for l = 1 : nombreLieu 
    if any(listeVilleEncoreDisponibles == ring(l)) == 1                      # si trajet vers lui-m�me alors 0  
    tau = matricePheromone(villeActuelle,l) + matriceDeltaPheromone(villeActuelle,l);# tau(i)(l) represente la quantite de pheromone sur le chemin entre la ville i et la ville l. C'est la pseudo-memoire du systeme. Delta represente les pheromone ajoute par les fourmis precedentes du m�me tour, c'est separer pour distinguer durant le processus d'evaluation
    distanceIJ = cost_ring(ring(villeActuelle), ring(l));
    eta = 1 /distanceIJ ;                                              # eta (i)(l) represente l'inverse de la distance entre la ville i et la ville l. C'est la visibilite du systeme   
    poidsTrajetTotal += (tau ^ alpha) * (eta ^ beta);                  # on ajoute le poid du trajet i vers l
  endif
endfor
  # apparte sur la selection du chemin -----------------------------------

  # Pour savoir quel chemin on prend, comme c'est dur de modeliser des probabilite, une solution que j'ai trouve c'est de
  # generer un nombre N entre 0 et 1 et si la probabilite P(i)(j) (proba de prendre le chemin de i vers j) est plus grande que ce nombre alors on prend ce chemin.
  # �a veut dire qu'on prend pas toujours le meilleur chemin (bien car peut eviter les maximaux locaux). Cependant on peut parfois ne jamais avoir P(i)(j) plus grand que N
  # auquel cas il ne choisi pas de chemin (par exemple si tous les chemins ont une m�me probabilite alors P sera petit).
  # une solution est de generer N au debut et de comparer  successivement par rapport � la somme des P(i)(j) jusqu'� ce que la somme soit sup�rieur 
  # et on prend le chemin dont la probabilite a fait basculer la balance.
  #�a fait surtout une difference au debut quand les probabilite sont relativement egale, apres plusieurs iterations il va prendre le chemin ayant la plus grande probabilite 
  
  nSeuilProbabilitePourChoixDuChemin = rand()
  sommeProbaDesTrajetIVersJ = 0;
  
  # calcul des probabilit�s ----------------------------------------------
  for j = 1 : nombreLieu
    if any(listeVilleEncoreDisponibles == ring(j)) == 1                         # si trajet vers lui-m�me alors 0                                                              # sinon calcul de la probabilite de prendre ce chemin
      j
      tau = matricePheromone(villeActuelle,j) + matriceDeltaPheromone(villeActuelle,j);# tau(i)(j) represente la quantite de pheromone sur le chemin entre la ville i et la ville j. C'est la pseudo-memoire du systeme. Delta represente les pheromone ajoute par les fourmis precedentes du m�me tour, c'est separer pour distinguer durant le processus d'evaluation
      distanceIJ = cost_ring(ring(villeActuelle), ring(j))
      eta = 1 /distanceIJ ;                                               # eta (i)(j) represente l'inverse de la distance entre la ville i et la ville j. C'est la visibilite du systeme.   
      poidsTrajetActuel = (tau ^ alpha) * (eta ^ beta);                   # le poid du trajet i vers j 
      listeProbaDuTrajetIVersJ(j) =poidsTrajetActuel / poidsTrajetTotal;  # rapport du poids du trajet actuel sur le poids total (comme �a la somme des probabilit�s des trajets de i vers tous les j vaut 1) (=normalisation)    
    endif 
    sommeProbaDesTrajetIVersJ +=   listeProbaDuTrajetIVersJ(j)
    
    # tirage de la route en fonction des probabilite calcule ---------------
    if sommeProbaDesTrajetIVersJ >= nSeuilProbabilitePourChoixDuChemin
      listeTrajetFourmi = [listeTrajetFourmi j]
      coutTrajetFourmi += cost_ring(ring(villeActuelle), ring(j));
      villeActuelle = j;
      break                                                             #si la route est tire alors on break
    endif
  endfor

  
endfunction
