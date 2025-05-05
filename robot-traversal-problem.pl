% Robot Traversal using Means-End Analysis in Prolog 

% Initial and goal states 
initial_state(pos(0,0)). 
goal_state(pos(3,3)). 

% Obstacles (example positions to avoid) 
obstacle(pos(1,3)). 
obstacle(pos(2,1)). 

% Possible moves 
move(pos(X, Y), pos(X1, Y)) :- X1 is X + 1, X1 =< 3. 
move(pos(X, Y), pos(X, Y1)) :- Y1 is Y + 1, Y1 =< 3. 
move(pos(X, Y), pos(X1, Y)) :- X1 is X - 1, X1 >= 0. 
move(pos(X, Y), pos(X, Y1)) :- Y1 is Y - 1, Y1 >= 0. 

% Manhattan distance heuristic 
manhattan_distance(pos(X, Y), pos(GX, GY), Dist) :- 
    Dist is abs(X - GX) + abs(Y - GY). 

% Means-End Analysis main predicate 
mea(Start, Goal, Path) :- 
    manhattan_distance(Start, Goal, H), 
    best_first_mea([[Start, [Start], H]], Goal, FinalPath), 
    reverse(FinalPath, Path). 

% Best-First Search styled MEA implementation 
best_first_mea([[State, Path, _]|_], Goal, Path) :- 
    State = Goal, !. 

best_first_mea([[State, Path, _]|Rest], Goal, FinalPath) :- 
    State \= Goal, 
    findall( 
        [NewState, [NewState|Path], H], 
        (move(State, NewState), 
         \+ member(NewState, [State|Path]), % Check against path to avoid cycles 
         \+ obstacle(NewState), 
         manhattan_distance(NewState, Goal, H)), 
        Neighbors 
    ), 
    append(Rest, Neighbors, NewFrontier), 
    sort_by_heuristic(NewFrontier, SortedFrontier), 
    best_first_mea(SortedFrontier, Goal, FinalPath). 
 
% Sorting paths based on heuristic value 
sort_by_heuristic(Paths, SortedPaths) :- 
    map_list_to_pairs(heuristic_value, Paths, Pairs), 
    keysort(Pairs, SortedPairs), 
    pairs_values(SortedPairs, SortedPaths). 
 
% Extract heuristic value 
heuristic_value([_, _, H], H). 
 
% Example query: ?- initial_state(Start), goal_state(Goal), mea(Start, Goal, Path). 