

function Verif(listering,listestar,star)
 N=length(listestar)
 for i=1:N
   if find(listering==i) 
     if find(star==i)
       disp ("Cet �l�ment est dans le ring et star"), disp (i)
     else
       if listestar(i,:)!=zeros(1,N)
          disp ("la ligne de la matrice n'est pas correcte" ), disp (i)
       endif
     endif 
   
     
     
       
   elseif find(star==i)
       if find(listestar(i,:)==1)
          idx=find(listestar(i,:)==1);
          if find(listering==idx)
            
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
