# fonction qui permute deux éléments du rings 

function  [listering]=V1_permut(listering,num1,num2 )
  
    temp=listering(num1);
    listering(num1)=listering(num2);
    listering(num2)=temp;
  
endfunction
