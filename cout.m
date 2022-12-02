# fonction qui calcul le cout 
function cout_total = cout (cost_ring,cost_star,listering,listestar)
  N= length(cost_ring);
  N=8
  cout_ring =0;
  cout_star =0;
  # cout du ring 
  for i=1:length(listering)-1
     cout_ring+=cost_ring(listering(i),listering(i+1));
  endfor
   cout_ring+=cost_ring(listering(end),listering(1));
   
  # cout des stars 
  for i=1:length(listering) 
    for j=1:N
      if listestar(i,j)==1 
        cout_star+=cost_star(i,j) ;
      endif
    endfor
  endfor
  
cout_total=cout_star+cout_ring;
endfunction
