from collections import deque 
 
def water_jug_solver(x, y, z): 
    visited = set() 
    queue = deque([(0, 0)])  # Start state (0,0) 
 
    while queue: 
        a, b = queue.popleft() 
        print(f"Current State: ({a}, {b})") 
 
        if a == z or b == z: 
            print(f"Solution found: ({a}, {b})") 
            return 
 
        if (a, b) in visited: 
            continue 
 
        visited.add((a, b)) 
 
        # Add all possible states to the queue 
        queue.extend([ 
            (x, b),  # Fill first jug 
            (a, y),  # Fill second jug 
            (0, b),  # Empty first jug 
            (a, 0),  # Empty second jug 
            (a - min(a, y - b), b + min(a, y - b)),  # Pour A -> B 
            (a + min(b, x - a), b - min(b, x - a))   # Pour B -> A 
        ])
        
    print("No solution found") 

# Example: Solve for jugs of size 4L and 3L, with goal 2L 
water_jug_solver(4, 3, 2)