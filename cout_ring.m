
function  cout =cout_ring(listering,cost_ring)
   # cout du ring 
   cout=0;
  for i=1:length(listering)-1
     cout+=cost_ring(listering(i+1),listering(i));
  endfor
   cout+=cost_ring(listering(1),listering(end));

endfunction
