# fonction qui calcul le cout 
function cout_total = cout(cost_ring,cost_star,ring ,star_matrice)
  N= length(cost_ring);

  cout_ring =0;
  cout_star =0;
  # cout du ring 
  for i=1:length(ring )-1
     cout_ring+=cost_ring(ring (i+1),ring (i));
  endfor
   cout_ring+=cost_ring(ring (1),ring (end));
   
  # cout des stars 
  for i= 1:N
    for j=ring 
      if star_matrice(i,j)==1 
        cout_star+=cost_star(j,i) ;
      endif
    endfor
  endfor
  
cout_total=cout_star+cout_ring;
endfunction
