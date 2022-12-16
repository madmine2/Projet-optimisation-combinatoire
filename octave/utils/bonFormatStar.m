function ListeStar = bonFormatStar(star_matrice)
  
[L,C] = size(star_matrice)
ListeStar = ones(L,2);
i = 1;
for l = 1:L 
  for c = 1:C
    if star_matrice(l,c) == 1
      ListeStar(i,1) = l;
      ListeStar(i,2) = c;
      i += 1 ;
    endif
  endfor
endfor


endfunction
