% Best-First Search (BFS) in Prolog 

% Graph edges with costs (not used in heuristic, but included for completeness) 
edge(a, b, 1). 
edge(a, c, 1). 
edge(b, d, 1). 
edge(c, e, 1). 
edge(c, f, 1). 
edge(d, f, 1). 
edge(e, f, 1). 
edge(f, j, 1). 

% Heuristic values (estimated cost to goal j) 
heuristic(a, 4). 
heuristic(b, 3). 
heuristic(c, 2). 
heuristic(d, 2). 
heuristic(e, 1). 
heuristic(f, 1). 
heuristic(j, 0). 

% Best-First Search main predicate 
best_first_search(Start, Goal, Path) :- 
    heuristic(Start, H), % Bind H to avoid singleton warning 
    best_first_search([[(Start, [Start]), H]], Goal, [], Path). 

% Base case: goal reached, return reversed path 
best_first_search([[(Goal, Path), _]|_], Goal, _, FinalPath) :- 
    reverse(Path, FinalPath). 

% Recursive case: expand node with lowest heuristic 
best_first_search([[(Node, Path), _]|Rest], Goal, Visited, FinalPath) :- 
    Node \= Goal, 
    findall( 
        [(Next, [Next|Path]), H], 
        (edge(Node, Next, _), \+ member(Next, Visited), heuristic(Next, H)), 
        Neighbors 
    ), 
    append(Rest, Neighbors, NewFrontier), 
    sort(2, @=<, NewFrontier, SortedFrontier), % Sort by heuristic value 
    best_first_search(SortedFrontier, Goal, [Node|Visited], FinalPath). 

% Example query: ?- best_first_search(a, j, Path). 