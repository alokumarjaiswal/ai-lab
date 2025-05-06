Prolog (Programming in Logic): It is a logic-based programming language where we define facts, rules & queries to solve problems.
1. Facts: Statements that are true, e.g., father(john, mary). (John is Mary's father).
2. Rules: Logical relationships, e.g., parent(X, Y) :- father(X, Y). (X is a parent of Y if X is the father of Y).
3. Queries: Questions we ask Prolog, e.g., ?- parent(john, mary). (Is John Mary's parent?).
4. Backtracking: Prolog tries different combinations to satisfy our query, automatically backtracking if a path fails.
5. Lists: Prolog uses lists (e.g., [1, 2, 3]) to represent data.
