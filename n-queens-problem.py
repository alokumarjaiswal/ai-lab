def is_safe(board, row, col, n): 
    """Check if it's safe to place a queen at board[row][col]""" 
    for i in range(row): 
        # Check if the column or diagonals are already occupied 
        if board[i] == col or abs(board[i] - col) == abs(i - row): 
            return False 
    return True 
 
def solve_n_queens(n, row=0, board=[]): 
    """Recursive function to solve N-Queens problem""" 
    if row == n: 
        print(board)  # Print the solution (could be in another format if needed) 
        return 
 
    for col in range(n): 
        if is_safe(board, row, col, n): 
            solve_n_queens(n, row + 1, board + [col])  # Add current column to the board 
 
# Example: Solve for 4 Queens 
solve_n_queens(4)