% Depth-First Search (DFS) in Prolog 

% Example graph represented as edges 
edge(a, b). 
edge(a, c). 
edge(b, d). 
edge(c, e). 
edge(c, f). 
edge(d, f). 
edge(e, f). 

% DFS main predicate: find path from Start to Goal 
dfs(Start, Goal, Path) :- 
    dfs_helper(Start, Goal, [Start], Path). 

% Base case: reached the goal 
dfs_helper(Goal, Goal, Visited, Path) :- 
    reverse(Visited, Path). 

% Recursive case: explore unvisited neighbors 
dfs_helper(Current, Goal, Visited, Path) :- 
    edge(Current, Next), 
    \+ member(Next, Visited), 
    dfs_helper(Next, Goal, [Next|Visited], Path). 

% Example query: ?- dfs(a, f, Path).