# fait toutes les possibilit�s et prend la meilleure 
# attention ne pas utiliser si trop grosses donn�es 
function best= tsp_exact (listering,cost_ring)

 # g�n�ration de toutes les permuations 
 perm=perms(listering);
 [m,N]=size(perm);
 best=listering;
 cout =cout_ring(best,cost_ring);


   
 for i=2:m
   cout_perm=cout_ring(perm(i,:),cost_ring);
   if cout_perm<cout
     cout=cout_perm;
     best=perm(i,:);
   endif
   
   
 endfor
endfunction
