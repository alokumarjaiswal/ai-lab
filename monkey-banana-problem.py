from collections import deque 
 
# Define the state class 
class State: 
    def __init__(self, monkey_pos, box_pos, banana_grabbed): 
        self.monkey_pos = monkey_pos  # 'floor' or 'box' 
        self.box_pos = box_pos  # position of the box (we'll just assume it stays fixed) 
        self.banana_grabbed = banana_grabbed  # True if banana is grabbed, False otherwise 
 
    def __eq__(self, other): 
        return (self.monkey_pos == other.monkey_pos and 
                self.box_pos == other.box_pos and 
                self.banana_grabbed == other.banana_grabbed) 
 
    def __hash__(self): 
        return hash((self.monkey_pos, self.box_pos, self.banana_grabbed)) 
 
    def __str__(self): 
        return f"Monkey: {self.monkey_pos}, Box: {self.box_pos}, Banana Grabbed: {self.banana_grabbed}" 
 
# Define the possible actions 
def actions(state): 
    moves = [] 
    # Move left or right (monkey can move only if it's on the floor) 
    if state.monkey_pos == 'floor': 
        moves.append('move_left') 
        moves.append('move_right') 
     
    # Climb the box (can only climb if on the floor and the box is there) 
    if state.monkey_pos == 'floor' and state.box_pos == 'under_banana': 
        moves.append('climb_on_box') 
     
    # Grab the banana (only if on the box and banana not grabbed yet) 
    if state.monkey_pos == 'box' and not state.banana_grabbed: 
        moves.append('grab_banana') 
 
    return moves 
 
# Define state transitions 
def transition(state, action): 
    if action == 'move_left': 
        new_pos = 'floor' 
        # Assuming room positions and boundaries are handled 
        # Change the state accordingly 
        return State(new_pos, state.box_pos, state.banana_grabbed) 
     
    elif action == 'move_right': 
        new_pos = 'floor' 
        # Again handle boundaries 
        return State(new_pos, state.box_pos, state.banana_grabbed) 
     
    elif action == 'climb_on_box': 
        return State('box', state.box_pos, state.banana_grabbed) 
     
    elif action == 'grab_banana': 
        return State('box', state.box_pos, True)  # Grabbed banana 
 
# BFS algorithm to find the solution 
def bfs(initial_state): 
    frontier = deque([initial_state])  # queue for BFS 
    explored = set()  # set to keep track of explored states 
 
    while frontier: 
        current_state = frontier.popleft() 
 
        # Check if goal state is reached 
        if current_state.banana_grabbed: 
            return current_state 
 
        explored.add(current_state) 
 
        # Explore all possible actions from the current state 
        for action in actions(current_state): 
            next_state = transition(current_state, action) 
            if next_state not in explored: 
                frontier.append(next_state) 
 
    return None  # If no solution found 
 
# Initial state: Monkey is on the floor, box is under the banana, and banana is not grabbed 
initial_state = State('floor', 'under_banana', False) 
 
# Run BFS to find the solution 
goal_state = bfs(initial_state) 
 
if goal_state: 
    print("Goal state reached:", goal_state) 
else: 
    print("No solution found.")