function [matriceTrajetsInRing,coutTrajetFourmi] = choixDuTrajetIVersJ(villeI, matriceTrajetsInRing,nombreLieu, matricePheromone,matriceDeltaPheromone,cost_ring, alpha, beta,coutTrajetFourmi)
  pkg load statistics;
  #préparations-------------------------------------------------------------
  listeProbaDuTrajetIVersJ = zeros(1,nombreLieu);
  poidsTrajetTotal = 0;
  for l = 1 : nombreLieu 
    if l == villeI                                                     # si trajet vers lui-même alors 0
      listeProbaDuTrajetIVersJ(l) = 0;
    elseif sum(matriceTrajetsInRing(:,l)) > 1                          # chaque 1 représente un trajet vers une autre ville, Chaque ville ne peut avoir que 2 trajet (1 entrant, 1 sortant)
        listeProbaDuTrajetIVersJ(l) = 0;
    else    
    tau = matricePheromone(villeI,l) + matriceDeltaPheromone(villeI,l);# tau(i)(l) represente la quantite de pheromone sur le chemin entre la ville i et la ville l. C'est la pseudo-memoire du systeme. Delta represente les pheromone ajoute par les fourmis precedentes du même tour, c'est separer pour distinguer durant le processus d'evaluation
    distanceIJ = cost_ring(villeI, l);
    eta = 1 /distanceIJ ;                                              # eta (i)(l) represente l'inverse de la distance entre la ville i et la ville l. C'est la visibilite du systeme   
      poidsTrajetTotal += (tau ^ alpha) * (eta ^ beta);                # on ajoute le poid du trajet i vers l
  endif
endfor
  # apparte sur la selection du chemin -----------------------------------

  # Pour savoir quel chemin on prend, comme c'est dur de modeliser des probabilite, une solution que j'ai trouve c'est de
  # generer un nombre N entre 0 et 1 et si la probabilite P(i)(j) (proba de prendre le chemin de i vers j) est plus grande que ce nombre alors on prend ce chemin.
  # ça veut dire qu'on prend pas toujours le meilleur chemin (bien car peut eviter les maximaux locaux). Cependant on peut parfois ne jamais avoir P(i)(j) plus grand que N
  # auquel cas il ne choisi pas de chemin (par exemple si tous les chemins ont une même probabilite alors P sera petit).
  # une solution est de generer N au debut et de comparer  successivement par rapport à la somme des P(i)(j) jusqu'à ce que la somme soit supérieur 
  # et on prend le chemin dont la probabilite a fait basculer la balance.
  #ça fait surtout une difference au debut quand les probabilite sont relativement egale, apres plusieurs iterations il va prendre le chemin ayant la plus grande probabilite 
  
  nSeuilProbabilitePourChoixDuChemin = rand(0,1);
  sommeProbaDesTrajetIVersJ = 0;
  
  # calcul des probabilités ----------------------------------------------
  for j = 1 : nombreLieu
    if j == villeI                                                      # si trajet vers lui-même alors 0
      listeProbaDuTrajetIVersJ(j) = 0;
    elseif sum(matriceTrajetsInRing(:,j)) > 1                           # chaque 1 représente un trajet vers une autre ville, Chaque ville ne peut avoir que 2 trajet (1 entrant, 1 sortant)
        listeProbaDuTrajetIVersJ(j) = 0;
    else                                                                # sinon calcul de la probabilite de prendre ce chemin
      tau = matricePheromone(villeI,j) + matriceDeltaPheromone(villeI,l);# tau(i)(j) represente la quantite de pheromone sur le chemin entre la ville i et la ville j. C'est la pseudo-memoire du systeme. Delta represente les pheromone ajoute par les fourmis precedentes du même tour, c'est separer pour distinguer durant le processus d'evaluation
      distanceIJ = cost_ring(villeI, j);
      eta = 1 /distanceIJ ;                                               # eta (i)(j) represente l'inverse de la distance entre la ville i et la ville j. C'est la visibilite du systeme.   
      poidsTrajetActuel = (tau ^ alpha) * (eta ^ beta);                 # le poid du trajet i vers j 
      listeProbaDuTrajetIVersJ(j) =poidsTrajetActuel / poidsTrajetTotal; # rapport du poids du trajet actuel sur le poids total (comme ça la somme des probabilités des trajets de i vers tous les j vaut 1) (=normalisation)    
    endif 
    sommeProbaDesTrajetIVersJ +=   listeProbaDuTrajetIVersJ(j);
    
    # tirage de la route en fonction des probabilite calcule ---------------
    if sommeProbaDesTrajetIVersJ >= nSeuilProbabilitePourChoixDuChemin
      matriceTrajetsInRing(villeI,j) = 1;
      matriceTrajetsInRing(j,villeI) = 1;
      coutTrajetFourmi += cost_ring(villeI, j);
      break                                                             #si la route est tire alors on break
    endif
  endfor

  
endfunction
