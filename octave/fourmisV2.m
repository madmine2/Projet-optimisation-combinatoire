function [best_ring,best_star_mat,best_star]=fourmisV2(cost_ring,cost_star,ring ,star_matrice,star)
  

  % Initialize the problem
n = length(ring); % Number of cities
falseRing = 1:n;
d = cost_ring; % Distance matrix    

% Initialize the ants
m = 10; % Number of ants
p = randperm(n); % Random starting city for each ant
x = zeros(m, n); % Paths taken by each ant
x(:, 1) = p;

% Set the hyperparameters
alpha = 1; % Pheromone weight
beta = 2; % Distance weight
rho = 0.1; % Pheromone evaporation rate

% Initialize the pheromone levels
tau = ones(n, n) / n^2;

% Run the ACO algorithm
for iter = 1:100
  % Step 3: Choose the next city for each ant
  for i = 1:m
    current_city = x(i, end);
    available_cities = setdiff(1:n, x(i, :));
    p = zeros(1, length(available_cities));
    for j = 1:length(available_cities)
      next_city = available_cities(j);
      p(j) = tau(current_city, next_city)^alpha * ...
             ((1./d(current_city, next_city))^beta);
    end
    p = p / sum(p); % Normalize the probabilities
    x(i, end+1) = randsample(available_cities, 1, true, p

endfunction
