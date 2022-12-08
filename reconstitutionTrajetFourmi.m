 function [trajetFourmiEnListe] = reconstitutionTrajetFourmi(matriceTrajetsInRing,nombreLieu)
   coutTrajetFourmi = 0;
   trajetFourmiEnListe = zeros(1,nombreLieu);
   # Pour la ville 1, on cherche un trajet, quand il est trouve on le suit jusqu'� revenir � la ville 1
   ville = 1;
   step = 1;
   while (true)
     if sum(matriceTrajetsInRing(ville,:) == 0  # Si il n'y a plus de chemin � partir de la ville o� on est c'est qu'on a fait le tour
        break
     endif
     for i = 1 : nombreLieu
        if matriceTrajetsInRing(ville,i) == 1 :
           trajetFourmiEnListe(step) = ville;
           matriceTrajetsInRing(ville,i) = 0;
           matriceTrajetsInRing(i , ville) = 0;
           ville = i;
        endif   
    endfor
    step +=1;
   endwhile
 endfunction
