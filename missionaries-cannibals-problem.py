from collections import deque 
 
# Define valid moves 
MOVES = [(1, 0), (2, 0), (0, 1), (0, 2), (1, 1)] 
 
def is_valid(state): 
    """Check if state is valid (no missionaries eaten)""" 
    m1, c1, boat, m2, c2 = state 
    return (m1 >= c1 or m1 == 0) and (m2 >= c2 or m2 == 0) 
 
def get_next_states(state): 
    """Generate valid next states""" 
    m1, c1, boat, m2, c2 = state 
    next_states = [] 
 
    if boat == 1:  # Boat on the left side 
        for m, c in MOVES: 
            if m1 - m >= 0 and c1 - c >= 0: 
                new_state = (m1 - m, c1 - c, 0, m2 + m, c2 + c) 
                if all(x >= 0 for x in new_state) and is_valid(new_state): 
                    next_states.append(new_state) 
    else:  # Boat on the right side 
        for m, c in MOVES: 
            if m2 - m >= 0 and c2 - c >= 0: 
                new_state = (m1 + m, c1 + c, 1, m2 - m, c2 - c) 
                if all(x >= 0 for x in new_state) and is_valid(new_state): 
                    next_states.append(new_state) 
 
    return next_states 
 
def missionaries_and_cannibals(): 
    """Solve using BFS""" 
    initial_state = (3, 3, 1, 0, 0)  # (Missionaries, Cannibals, Boat, Missionaries on Right, Cannibals on Right) 
    goal_state = (0, 0, 0, 3, 3)     # Goal: All moved safely to the right side 
 
    queue = deque([(initial_state, [])])  # (current state, path) 
    visited = set() 
 
    while queue: 
        state, path = queue.popleft() 
 
        if state == goal_state: 
            print("Solution Found:", path + [state]) 
            return 
 
        if state in visited: 
            continue 
        visited.add(state) 
 
        for next_state in get_next_states(state): 
            queue.append((next_state, path + [state])) 
 
    print("No solution found") 
 
# Run the problem solver 
missionaries_and_cannibals()