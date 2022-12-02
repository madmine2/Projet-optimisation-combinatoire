M = dlmread('instance1.txt') %Use a better name that M
N = M(1:1)
matrice1 = M(2:1+N,:)
matrice1 = M(2+N:1+2*N,:)