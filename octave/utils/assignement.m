# fonction qui assigne les �l�ments stars au �l�ments de ring en minimisant le cout 
function  star_matrice = assignement (star,cost_star,ring )
  N=length(cost_star);
  
  star_matrice=zeros(N,N);
  for i=star
    [minval, idx]=min(cost_star(i,ring )) ;
    star_matrice(i,ring (idx))=1;
  endfor
  

endfunction
