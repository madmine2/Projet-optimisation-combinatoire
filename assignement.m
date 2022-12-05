# fonction qui assigne les éléments stars au éléments de ring en minimisant le cout 
function  star_matrice = assignement (star,cost_star,ring )
  N=length(cost_star);
  
  star_matrice=zeros(N,N);
  for i=star
    [minval, idx]=min(cost_star(i,ring )) ;
    star_matrice(i,ring (idx))=1;
  endfor
  

endfunction
