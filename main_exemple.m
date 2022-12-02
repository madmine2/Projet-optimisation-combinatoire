# Initialisation ----------------
fileName = 'instance1.txt';

file = dlmread(fileName);
N = file(1:1);
cost_ring = file(2:1+N,:);
cost_star = file(2+N:1+2*N,:);
# matrice N*N  

# Algo --------------------------
[listering,listestar,star]=Ini_min_somme(cost_ring,cost_star);





# Calcul du Cost ----------------
cout_total = cout (cost_ring,cost_star,listering,listestar);
# Output ------------------------


##dlmwrite(['output/out',fileName],["RING ",mat2str(length(Listering))],delim="");
##dlmwrite(['output/out',fileName],Listering,delim=" ", "-append");
##dlmwrite(['output/out',fileName],"STAR",delim="", "-append");
##dlmwrite(['output/out',fileName],ListeStar,delim=" ", "-append");
##dlmwrite(['output/out',fileName],["COST ",mat2str(Cost)],delim="", "-append");




