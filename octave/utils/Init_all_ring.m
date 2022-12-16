# fct d'initialisation random 

function [ring ,star_matrice,star]=Init_all_ring(cost_ring,cost_star)
  N=length(cost_ring);
  ring =[];
  star=[];
  star_matrice=zeros(N,N);
  for i=1:N
   
    if rand<=1 
      ring (end+1) = i;
    else 
      star(end+1)=i;
    endif
    
  endfor
  star_matrice = assignement (star,cost_star,ring );

  
endfunction
