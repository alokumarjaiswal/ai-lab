:- use_module(library(lists)). 

% Cities 
cities([a, b, c, d]). 

% Symmetric distances 
distance(a, b, 10). 
distance(a, c, 15). 
distance(a, d, 20). 
distance(b, c, 35). 
distance(b, d, 26). 
distance(c, d, 30). 
distance(X, Y, D) :- distance(Y, X, D). 

% Calculate total cost of a path 
path_cost([_], 0). 
path_cost([A, B | T], Cost) :- 
    distance(A, B, D), 
    path_cost([B | T], Rest), 
    Cost is D + Rest. 

% TSP entry point 
tsp(Start, BestPath, MinCost) :- 
    cities(Cities), 
    delete(Cities, Start, RestCities), 
    find_min_tour(Start, RestCities, BestPath, MinCost). 

% Try all permutations and track the minimum 
find_min_tour(Start, Cities, BestPath, MinCost) :- 
    find_min_tour(Start, Cities, none, inf, BestPath, MinCost). 
 
% Base case: no more permutations 
find_min_tour(_, [], BestPath, MinCost, BestPath, MinCost). 
 
% Recursive permutation check 
find_min_tour(Start, Cities, CurrentBestPath, CurrentMinCost, BestPath, MinCost) :- 
    permutation(Cities, Perm), 
    Tour = [Start | Perm], 
    append(Tour, [Start], FullTour), 
    path_cost(FullTour, Cost), 
    ( 
        Cost < CurrentMinCost 
        -> NewBestPath = Tour, NewMinCost = Cost 
        ;  NewBestPath = CurrentBestPath, NewMinCost = CurrentMinCost 
    ), 
    % Remove the current permutation from consideration 
    delete_permutation(Cities, Perm, RemainingPerms), 
    try_remaining_perms(Start, RemainingPerms, NewBestPath, NewMinCost, BestPath, MinCost). 
 
% Try remaining permutations 
try_remaining_perms(_, [], BestPath, MinCost, BestPath, MinCost). 
try_remaining_perms(Start, [P|Ps], CurrentBestPath, CurrentMinCost, BestPath, MinCost) :- 
    Tour = [Start | P], 
    append(Tour, [Start], FullTour), 
    path_cost(FullTour, Cost), 
    ( 
        Cost < CurrentMinCost 
        -> NewBestPath = Tour, NewMinCost = Cost 
        ;  NewBestPath = CurrentBestPath, NewMinCost = CurrentMinCost 
    ), 
    try_remaining_perms(Start, Ps, NewBestPath, NewMinCost, BestPath, MinCost). 
 
% Helper to get all permutations except one 
delete_permutation(Cities, Current, Others) :- 
    findall(P, (permutation(Cities, P), P \= Current), Others).

% Example query: ?- tsp(a, Path, Cost).