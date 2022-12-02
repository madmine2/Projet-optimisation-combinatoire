# fct d'initialisation random 

function [listering,listestar,star]=Ini_min_somme(cost_ring,cost_star)
  N=length(cost_ring);
  listering=[];
  star=[];
  listestar=zeros(N,N);
  for i=1:N
   
    if rand<0.5 
      listering(end+1) = i;
    else 
      star(end+1)=i;
    endif
    
  endfor
  listestar = assignement (star,cost_star,listering);

  
endfunction
