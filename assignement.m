# fonction qui assigne les �l�ments stars au �l�ments de ring en minimisant le cout 
function  listestar = assignement (star,cost_star,listering)
  N=length(cost_star);
  
  listestar=zeros(N,N);
  for i=star
    [minval, idx]=min(cost_star(i,listering)) ;
    listestar(i,listering(idx))=1;
  endfor
  

endfunction
