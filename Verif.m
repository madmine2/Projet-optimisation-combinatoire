

function Verif(ring ,star_matrice,star)
 N=length(star_matrice)
 for i=1:N
   if find(ring ==i) 
     if find(star==i)
       disp ("Cet �l�ment est dans le ring et star"), disp (i)
     else
       if star_matrice(i,:)!=zeros(1,N)
          disp ("la ligne de la matrice n'est pas correcte" ), disp (i)
       endif
     endif 
   
     
     
       
   elseif find(star==i)
       if find(star_matrice(i,:)==1)
          idx=find(star_matrice(i,:)==1);
          if find(ring ==idx)
            
          else
           disp(' pas attribu� � un ring'),disp(i)
          endif
          
       else 
          disp ("l'�l�ment n'est pas attribu�" ), disp (i)
       endif
       
     
   else 
     disp ("Il manque l'�l�ment "), disp (i)
   endif
 endfor


endfunction
