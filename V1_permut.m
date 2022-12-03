# fonction qui permute deux éléments du rings aléatoirement 

function  [listering]=V1_permut(listering )
  N=length(listering);
  num=randi(N);
  if num==N
    temp=listering(num);
    listering(num)=listering(1);
    listering(1)=temp;
    
  else
    temp=listering(num);
    listering(num)=listering(num+1);
    listering(num+1)=temp;
    
  endif
  

endfunction
