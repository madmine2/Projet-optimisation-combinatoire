
function  cout =cout_ring(ring ,cost_ring)
   # cout du ring 
   cout=0;
  for i=1:length(ring )-1
     cout+=cost_ring(ring (i+1),ring (i));
  endfor
   cout+=cost_ring(ring (1),ring (end));

endfunction
