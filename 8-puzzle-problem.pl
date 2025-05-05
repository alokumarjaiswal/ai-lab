% 8-Puzzle solver using Best-First Search in Prolog 

% Initial and goal states 
initial_state([1, 0, 3, 4, 2, 5, 7, 8, 6]). % 0 represents empty tile 
goal_state([1, 2, 3, 4, 5, 6, 7, 8, 0]). 

% Best-First Search entry point 
solve_8_puzzle(Solution) :- 
    initial_state(Start), 
    best_first_search([[Start]], Solution). 

% Best-First Search implementation 
best_first_search([[State|Path]|_], [State|Path]) :- 
    goal_state(State), !. 

best_first_search([StatePath|OtherPaths], Solution) :- 
    expand(StatePath, ExpandedPaths), 
    append(OtherPaths, ExpandedPaths, UpdatedPaths), 
    sort_by_heuristic(UpdatedPaths, SortedPaths), 
    best_first_search(SortedPaths, Solution). 

% Expanding nodes 
expand([State|Path], NewPaths) :- 
    findall([NewState, State|Path], 
        (move(State, NewState), \+ member(NewState, Path)), 
        NewPaths). 

% Define possible moves 
move(State, NewState) :- swap(State, NewState). 

% Swap the empty tile (0) with a valid adjacent tile 
swap(State, NewState) :- 
    nth0(Pos0, State, 0), 
    neighbor(Pos0, NewPos), 
    nth0(NewPos, State, Tile), 
    replace(State, Pos0, Tile, Temp), 
    replace(Temp, NewPos, 0, NewState). 

% Define valid movements 
neighbor(0, 1). neighbor(0, 3). 
neighbor(1, 0). neighbor(1, 2). neighbor(1, 4). 
neighbor(2, 1). neighbor(2, 5). 
neighbor(3, 0). neighbor(3, 4). neighbor(3, 6). 
neighbor(4, 1). neighbor(4, 3). neighbor(4, 5). neighbor(4, 7). 
neighbor(5, 2). neighbor(5, 4). neighbor(5, 8). 
neighbor(6, 3). neighbor(6, 7). 
neighbor(7, 4). neighbor(7, 6). neighbor(7, 8). 
neighbor(8, 5). neighbor(8, 7). 

% Replace an element in a list 
replace([_|T], 0, X, [X|T]). 
replace([H|T], I, X, [H|R]) :- 
    I > 0, NI is I - 1, replace(T, NI, X, R). 

% Sorting paths based on heuristic value 
sort_by_heuristic(Paths, SortedPaths) :- 
    map_list_to_pairs(heuristic_value, Paths, Pairs), 
    keysort(Pairs, SortedPairs), 
    pairs_values(SortedPairs, SortedPaths). 

% Compute heuristic (Manhattan Distance) 
heuristic_value([State|_], H) :- 
    manhattan_distance(State, H). 

% Manhattan Distance Calculation 
manhattan_distance(State, Dist) :- 
    goal_state(Goal), 
    findall(D, (nth0(I, State, Tile), Tile \= 0, nth0(GI, Goal, Tile), distance(I, GI, D)), 
    DList), 
    sumlist(DList, Dist). 

% Manhattan Distance Helper 
distance(Pos1, Pos2, D) :- 
    X1 is Pos1 mod 3, Y1 is Pos1 // 3, 
    X2 is Pos2 mod 3, Y2 is Pos2 // 3, 
    D is abs(X1 - X2) + abs(Y1 - Y2). 

% Example query: ?- solve_8_puzzle(Path).