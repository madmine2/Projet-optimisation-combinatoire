function [newring ,newstar_matrice, newstar] =  recuit_simule(cost_ring, cost_star, ring, star_matrice, star)
newring = ring;
newstar = star;
newstar_matrice =star_matrice;
newvalue = cout(cost_ring,cost_star,newring,newstar_matrice)

% Définir les paramètres du recuit simulé
temperature = 100; % La température initiale
alpha = 0.99; % La vitesse de refroidissement

t=0;
while t< 3*60
  
% Générer un voisin
[best_ring,best_star_mat,best_star,best_value]=Meilleur_Voisin(cost_ring,cost_star,ring,star_matrice,star);
 
% Calculer la différence d'énergie entre la nouvelle solution et l'ancienne
delta_e = best_value - newvalue;

% Si la nouvelle solution est meilleure, la sélectionner
if delta_e < 0
  newring = best_ring;
  newstar = best_star;
  newstar_matrice = best_star_mat;
% Sinon, sélectionner la nouvelle solution avec une probabilité dépendante de la température
else
  prob = exp(-delta_e / temperature);
  if rand() < prob
    newring = best_ring;
    newstar = best_star;
    newstar_matrice = best_star_mat;
   end
end
newvalue
% Refroidir la température
  temperature = temperature * alpha;
endwhile
endfunction