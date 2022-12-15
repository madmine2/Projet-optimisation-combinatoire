clear all;clc;
# Ajoute les fonctions � l'interieur du dossier fourni aux fonctions connus
addpath("algo fourmis")
addpath("utils")
addpath("algo voisinage variable")
addpath("algo tabou")
#addpath("algo grasp")
#addpath("algo recui")
# Initialisation ----------------

  fileName = 'instance1.txt';

  file = dlmread(fileName);
  N = file(1:1);
  cost_ring = file(2:1+N,:);
  cost_star = file(2+N:1+2*N,:);



# Solution initiale  --------------------------

  % initialisation aleatoire

  [ring ,star_matrice,star]=Ini_min_somme(cost_ring,cost_star);


# Algorithme --------------------------
  
  [ring ,star_matrice,star]=Recuit_variable(cost_ring,cost_star,ring ,star_matrice,star)
  %[ring ,star_matrice,star]=recherche_tabou(cost_ring, cost_star, ring, star_matrice, star, 10);
  #[ring ,star_matrice,star]=fourmis(cost_ring, cost_star, ring, star_matrice, star);

# Verification de la solution  --------------------------

  Verif(ring ,star_matrice,star)

# Calcul du Cost ----------------

  cout_total = cout (cost_ring,cost_star,ring ,star_matrice);

# Output ------------------------

  # faire la transition

  ##dlmwrite(['output/out',fileName],["RING ",mat2str(length(Listering))],delim="");
  ##dlmwrite(['output/out',fileName],Listering,delim=" ", "-append");
  ##dlmwrite(['output/out',fileName],"STAR",delim="", "-append");
  ##dlmwrite(['output/out',fileName],ListeStar,delim=" ", "-append");
  ##dlmwrite(['output/out',fileName],["COST ",mat2str(Cost)],delim="", "-append");




