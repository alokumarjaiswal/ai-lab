def print_board(board): 
    print("\n".join([" | ".join(row) for row in board])) 
    print("\n") 
 
def check_winner(board, player): 
    # Check rows 
    if any(all(cell == player for cell in row) for row in board): 
        return True 
    # Check columns 
    if any(all(board[row][col] == player for row in range(3)) for col in range(3)): 
        return True 
    # Check diagonals 
    if all(board[i][i] == player for i in range(3)): 
        return True 
    if all(board[i][2 - i] == player for i in range(3)): 
        return True 
    return False 
 
def get_available_moves(board): 
    return [(r, c) for r in range(3) for c in range(3) if board[r][c] == "_"] 
 
def play(): 
    board = [["_"] * 3 for _ in range(3)] 
    player = "X" 
 
    while "_" in [cell for row in board for cell in row]: 
        print_board(board) 
        move = input(f"Player {player}, enter row and col (e.g., 1 2): ") 
        try: 
            r, c = map(int, move.split()) 
            if board[r][c] != "_": 
                print("Invalid move! Try again.") 
                continue 
        except (ValueError, IndexError): 
            print("Invalid input! Enter two numbers from 0 to 2.") 
            continue 
 
        board[r][c] = player 
 
        if check_winner(board, player): 
            print_board(board) 
            print(f"Player {player} wins!") 
            return 
 
        player = "O" if player == "X" else "X" 
 
    print_board(board) 
    print("It's a draw!") 
 
# Run the game 
play()