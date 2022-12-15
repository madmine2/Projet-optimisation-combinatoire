function [newring ,newstar_matrice, newstar] =  recuit_simule(cost_ring, cost_star, ring, star_matrice, star)
newring = ring;
newstar = star;
newstar_matrice =star_matrice;
newvalue = cout(cost_ring,cost_star,newring,newstar_matrice)

% D�finir les param�tres du recuit simul�
temperature = 100; % La temp�rature initiale
alpha = 0.99; % La vitesse de refroidissement

t=0;
while t< 3*60
  
% G�n�rer un voisin
[best_ring,best_star_mat,best_star,best_value]=Meilleur_Voisin(cost_ring,cost_star,ring,star_matrice,star);
 
% Calculer la diff�rence d'�nergie entre la nouvelle solution et l'ancienne
delta_e = best_value - newvalue;

% Si la nouvelle solution est meilleure, la s�lectionner
if delta_e < 0
  newring = best_ring;
  newstar = best_star;
  newstar_matrice = best_star_mat;
% Sinon, s�lectionner la nouvelle solution avec une probabilit� d�pendante de la temp�rature
else
  prob = exp(-delta_e / temperature);
  if rand() < prob
    newring = best_ring;
    newstar = best_star;
    newstar_matrice = best_star_mat;
   end
end
newvalue
% Refroidir la temp�rature
  temperature = temperature * alpha;
endwhile
endfunction