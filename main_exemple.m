# Initialisation ----------------
fileName = 'instance1.txt';

file = dlmread(fileName);
N = file(1:1);
matrice1 = file(2:1+N,:);
matrice2 = file(2+N:1+2*N,:);

Listering = [1,2,3,4];
ListeStar = [4,1;5,4];
# Algo --------------------------




# Calcul du Cost ----------------
Cost = 5;
# Output ------------------------


dlmwrite(['output/out',fileName],["RING ",mat2str(length(Listering))],delim="");
dlmwrite(['output/out',fileName],Listering,delim=" ", "-append");
dlmwrite(['output/out',fileName],"STAR",delim="", "-append");
dlmwrite(['output/out',fileName],ListeStar,delim=" ", "-append");
dlmwrite(['output/out',fileName],["COST ",mat2str(Cost)],delim="", "-append");



