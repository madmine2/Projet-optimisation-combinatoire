

function Verif(listering,listestar,star)
 N=length(listestar)
 for i=1:N
   if find(listering==i) 
     if find(star==i)
       disp ("Cet élément est dans le ring et star"), disp (i)
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
           disp(' pas attribué à un ring'),disp(i)
          endif
          
       else 
          disp ("l'élément n'est pas attribué" ), disp (i)
       endif
       
     
   else 
     disp ("Il manque l'élément "), disp (i)
   endif
 endfor


endfunction
