% 8-Queens solver in Prolog (first 10 solutions, SWISH-compatible) 

% Main predicate to solve 8-Queens 
queens(N, Queens) :- 
    range(1, N, Rows), 
    queens(Rows, [], Queens). 

% Base case: all rows processed 
queens([], Queens, Queens). 

% Recursive case: place queen in current row 
queens([Row|Rows], Partial, Queens) :- 
    select_col(Row, Col), 
    safe(Partial, Row, Col), 
    queens(Rows, [(Row, Col)|Partial], Queens). 

% Generate range from Low to High 
range(Low, High, [Low|Rest]) :- 
    Low =< High, 
    Next is Low + 1, 
    range(Next, High, Rest). 
range(_, _, []). 

% Select a column for the queen 
select_col(_, Col) :- 
    between(1, 8, Col). 

% Check if queen placement is safe 
safe([], _, _). 
safe([(Row2, Col2)|Queens], Row1, Col1) :- 
    Row1 \= Row2, 
    Col1 \= Col2, 
    abs(Row1 - Row2) \= abs(Col1 - Col2), 
    safe(Queens, Row1, Col1). 

% Convert solution to list of columns [Col1, Col2, ..., Col8] 
format_solution(Solution, Cols) :- 
    sort(1, @=<, Solution, Sorted), 
    maplist(get_col, Sorted, Cols). 

% Extract column from (Row, Col) pair 
get_col((_, Col), Col). 

% Helper predicate with counter 
solve_queens(Board) :- 
    solve_queens_helper(1, 10, Board). 

% Helper to track solution count 
solve_queens_helper(Count, Max, Board) :- 
    Count =< Max, 
    queens(8, Solution), 
    format_solution(Solution, Board), 
    write(Board), nl, 
    NextCount is Count + 1, 
    (NextCount =< Max -> solve_queens_helper(NextCount, Max, Board); true). 

% Example query: ?- solve_queens(Board).