# fonction qui permute deux éléments du rings 

function  [ring ]=V1_permut(ring ,num1,num2 )
  
    temp=ring (num1);
    ring (num1)=ring (num2);
    ring (num2)=temp;
  
endfunction
