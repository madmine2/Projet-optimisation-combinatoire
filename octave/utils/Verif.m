

function Verif(ring ,star_matrice,star,M)

 N=length(star_matrice);
 if  N != M 
 disp ("La star matrice n'a pas la bonne taille")
endif
 if  (length(ring) + length(star)) != M 
 disp ("star et ring n ont pas la bonne taille")
 endif
 for i=1:N
   if find(ring ==i) 
     if find(star==i)
       disp ("Cet élément est dans le ring et star"), disp (i)
     else
       if star_matrice(i,:)!=zeros(1,N)
          disp ("la ligne de la matrice n'est pas correcte" ), disp (i)
       endif
     endif 
   
  elseif length(find(ring ==i))> 1
       disp ("Cet élément est plusieus fois dans ring"), disp (i)
  
  elseif length(find(star ==i))> 1
       disp ("Cet élément est plusieus fois dans star"), disp (i)
  
       
   elseif find(star==i)
       if find(star_matrice(i,:)==1)
          idx=find(star_matrice(i,:)==1);
          if find(ring ==idx)
            
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
