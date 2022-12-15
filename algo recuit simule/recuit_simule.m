function [newring ,newstar_matrice, newstar] =  recuit_simule(cost_ring, cost_star, ring, star_matrice, star)
newring = ring;
newstar = star;
newstar_matrice =star_matrice;
%température ( la faire varier)
T = 10000
%cout initaial
newval = cout(cost_ring,cost_star,newring,newstar_matrice)
%dirtribution de Boltzman pour probabilté d'acceptation
rand
t=0;
while t< 3*60
[ring, star_matrice, star]= Echange(cost_ring, cost_star, newring, newstar_matrice, newstar);
val = cout(cost_ring,cost_star,ring,star_matrice)
F = newval - val
   if F>0
     newring = ring;
     newstar = star;
     newstar_matrice =star_matrice;
   else
     p = exp(F/T)
     if p>rand
       newring = ring;
       newstar = star;
       newstar_matrice =star_matrice;
     else
       [ring, star_matrice, star]= Ajout(cost_ring, cost_star, newring, newstar_matrice, newstar);
       val = cout(cost_ring,cost_star,ring,star_matrice)
       F = newval - val
       if F>0
         newring = ring;
         newstar = star;
         newstar_matrice =star_matrice;
       else
         p = exp(F/T)
         if p>rand
           newring = ring;
           newstar = star;
           newstar_matrice =star_matrice;
         else
          [ring, star_matrice, star]=  Supression(cost_ring, cost_star, newring, newstar_matrice, newstar);
           val = cout(cost_ring,cost_star,ring,star_matrice)
           F = newval - val
           if F>0
             newring = ring;
             newstar = star;
             newstar_matrice =star_matrice;
           else
             p = exp(F/T)
             if p>rand
               newring = ring;
               newstar = star;
               newstar_matrice =star_matrice;
             endif
           endif
         endif
       endif
     endif
    endif
newval=val
T=0.9*T
endwhile
endfunction