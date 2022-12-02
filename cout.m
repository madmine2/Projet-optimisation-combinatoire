# fonction qui calcul le cout 
function cout_total = cout (cost_ring,cost_star,listering,listestar)
  N= length(cost_ring);

  cout_ring =0;
  cout_star =0;
  # cout du ring 
  for i=1:length(listering)-1
     cout_ring+=cost_ring(listering(i+1),listering(i));
  endfor
   cout_ring+=cost_ring(listering(1),listering(end));
   
  # cout des stars 
  for i=1:length(listering) 
    for j=1:N
      if listestar(i,j)==1 
        cout_star+=cost_star(j,i) ;
      endif
    endfor
  endfor
  
cout_total=cout_star+cout_ring;
endfunction
