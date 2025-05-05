% Define winning conditions 
win(Player, Board) :- 
    Board = [Player, Player, Player, _, _, _, _, _, _]; % Row 1 
    Board = [_, _, _, Player, Player, Player, _, _, _]; % Row 2 
    Board = [_, _, _, _, _, _, Player, Player, Player]; % Row 3 
    Board = [Player, _, _, Player, _, _, Player, _, _]; % Col 1 
    Board = [_, Player, _, _, Player, _, _, Player, _]; % Col 2 
    Board = [_, _, Player, _, _, Player, _, _, Player]; % Col 3 
    Board = [Player, _, _, _, Player, _, _, _, Player]; % Diagonal 
    Board = [_, _, Player, _, Player, _, Player, _, _]. % Anti-diagonal 
 
% Display the board 
display_board([A, B, C, D, E, F, G, H, I]) :- 
    write(A), write(' | '), write(B), write(' | '), write(C), nl, 
    write('---------'), nl, 
    write(D), write(' | '), write(E), write(' | '), write(F), nl, 
    write('---------'), nl, 
    write(G), write(' | '), write(H), write(' | '), write(I), nl. 
 
% Make a move if the cell is empty 
move(Board, Player, Index, NewBoard) :- 
    nth0(Index, Board, '_'), % Ensure position is empty 
    replace(Board, Index, Player, NewBoard). 
 
% Replace an element in a list 
replace([_|T], 0, X, [X|T]). 
replace([H|T], I, X, [H|R]) :- 
    I > 0, 
    NI is I - 1, 
    replace(T, NI, X, R). 
 
% Play the game 
play(Board, Player) :- 
    display_board(Board), 
    ( win('X', Board) -> write('X wins!'), nl; 
      win('O', Board) -> write('O wins!'), nl; 
      \+ member('_', Board) -> write('Draw!'), nl; 
      switch_player(Player, NextPlayer), 
      write(Player), write(', enter move (0-8): '), 
      read(Index), 
      ( move(Board, Player, Index, NewBoard) -> 
            play(NewBoard, NextPlayer) 
      ;   write('Invalid move. Try again.'), nl, 
play(Board, Player) 
) 
). 
% Switch players 
switch_player('X', 'O'). 
switch_player('O', 'X'). 
% Start the game 
start :- 
play(['_', '_', '_', '_', '_', '_', '_', '_', '_'], 'X').

% Example usage: ?- start.