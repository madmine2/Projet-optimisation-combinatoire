

function   elem_star=extrait_star(centre_star,listestar)
  elem_star=[];
  N=length(listestar);
  for i=1:N
    if listestar(centre_star,i)==1

      elem_star(end+1)= i;
    endif
  endfor
endfunction
