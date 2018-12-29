/*******************************************/
/**    Your solution goes in this file    **/ 
/*******************************************/

%HELPER FUNCTIONS For THIS PROGRAM

%This predicate helps to check for equal values in the programs (not the same as isEqual in 2d)
isequal(X,X).

% A method to solve for finding the first common value for [H|T] in L2
common([H|T],L2):-
    isMember(H,L2),!;common(T,L2).

% My own recursive append to implement appending of lists.
myappend([],L,L).   %base case
myappend([X|L1],L2,[X|L3]) :- myappend(L1,L2,L3).

% PART 1a) Find all the names of the novels that have been published in either 1953 or 1996.
year_1953_1996_novels(N) :-
    novel(N, Y), (Y=1953;Y=1996).
    
% Part 1b) Find all the names of the novels that have been published during the period 1800 to 1900.
period_1800_1900_novels(N) :-
    novel(N,Y),(Y >= 1800),(Y =< 1900).

% Part 1c) Find all the names of the characters who are fans of the lord of the rings.
lotr_fans(F) :-
    fan(F,L),member(the_lord_of_the_rings,L).

%Part 1d) Find all the names of the authors whose novels chandler is a fan of.
author_names(A):-
    fan(chandler,L1),author(A,L2),common(L1,L2).

%Part 1e) Find all the names of the characters who are fans of the novels authored by brandon sanderson.
fans_names(F):-
    author(brandon_sanderson,L1),fan(F,L2),common(L1,L2).
    
%Part 1f) Find all the names of the novels that are common between either of phoebe, ross and monica.
mutual_novels(X):-
    fan(phoebe,L1),fan(ross,L2),fan(monica,L3), %L1,L2,L3 contains lists of books liked by each of the three
    (
        % It is an or case of taking any books common between pairs of the three people
        
        (isMember(X,L2),isMember(X,L3));
        (isMember(X,L1),isMember(X,L3));
        (isMember(X,L1),isMember(X,L2))
        
    ).

%Part 2a) Define the isMember predicate so that isMember(X,Y) says that element X is a member of Y.
  
isMember(X,[H|_]):- isequal(X,H). %base case when X == an element in the list.

isMember(X,[H|T]):-               %recurses through the list till X is found.
    isMember(X,T).

% Part 2b) Define the isUnion predicate so that isUnion(X,Y,Z) says that the union of X and Y is Z

isUnion([],Y,Y).    %base case when X is empty, then the union is X U Y = Y.

isUnion([H|T],Y,Z):-    %check if H is in Y and recurse through X and find the union in Z
    isMember(H,Y),!,isUnion(T,Y,Z).

isUnion([H|T],Y,[H|Z]):-    %add H to Z if not in Y (uncommon elements of X and Y).
    \+isMember(H,Y),isUnion(T,Y,Z).



%Part 2c) Define the isIntersection predicate so that isIntersection(X,Y,Z) says that the intersection of X and Y is Z.

isIntersection([],Y,[]).        %base case when X is empty, then nothing in common.

isIntersection([H|T],Y,[H|Z]):- %add H to Z if it is in Y and recurse through X and store result in T.
    isMember(H,Y),isIntersection(T,Y,Z).

isIntersection([H|T],Y,Z):-     %ignore for elements which are not in Y but in X (uncommon elements).
    \+isMember(H,Y),isIntersection(T,Y,Z).


%Part 2d)Define the isEqual predicate so that isEqual(X,Y) says that the sets X and Y are equal.

isEqual([],Y).  %base case when X is empty, just ignore it and it is true only if Y is empty.

isEqual([H1|T1],[H2|T2]):-
    
    %check if current elements match or check if H1 is in Y([H2|T2]) and recurse through X.
    
    (isequal(H1,H2);(isMember(H1,[H2|T2]))),!,isEqual(T1,[H2|T2]).
    
%Part 2e)Define the powerSet predicate so that powerSet(X,Y) says that the powerset of X is Y.

powerSet([],[[]]).  %base case when X is empty, then Y is set of an empty set
powerSet([H1|T1],Y):-   % case to check the powerset of Y with each decomposition of T1.
    powerSet(T1,Y1),    %recurse till T1 is empty and store the powerset of T in Y1.
    subsets(H1,Y1,Y2),  % another method to collect singleton sets and sets of combinations of each elements in X, stored in Y2.
    myappend(Y1,Y2,Y).  % Append the sets Y1 and Y2 into the set Y.

subsets(_,[],[]).   
subsets(X,[S|S1],Y):-   %recurses through powerset of T1 (refer above) to form sets with singleton elements and seperate combinations of each.
    myappend([X],S,Temp1),  %append set of X (a single element), to S to get temp1
    subsets(X,S1,Temp2),    %find subsets of S1 into temp2.
    myappend([Temp1],Temp2,Y). %set of Temp1(seperate combinations of each elements in the original set) to be appended with Temp2 to get Y.


%Part 3) PUZZLE
/*
The task is to define the rule solve(F1,W1,G1,C1,F2,W2,G2,C2) that prints the
moves that should be taken to go from the initial state of the farmer (F1), wolf (W1), goat
(G1), and cabbage (C1) to their respective final state F2, W2, G2 and C2
*/
/*  make a move
    check if it is safe
    check if new state is already visited.
    pass the new state to a recursive call
*/
state(F,W,G,C).                             % a simple rule to take four different states of each objects.
take(Obj, A, B) :- opposite(A, B).          % check for a meaningful move only if A and B are opposite banks.

% opposite banks rule.
opposite(left, right).                      
opposite(right, left).

% safe only if wolf and goat are opposite and Goat and cabbage are opposite. If not in each case, the farmer must be on the same bank.
safe(state(F, W, G, C)) :- (opposite(W,G);(\+opposite(W,G),isequal(F,G))),
                            (opposite(G,C);\+opposite(G,C),isequal(F,G)).

% unsafe is not(safe).                   
unsafe(A) :- \+safe(A).

%The arc predicate:
% It takes a move(none other than a take), state A and state B. 
% It switches the state for the farmer if there is a move for any of the three objects.
% always there is a check for non-null takes and also safety of state B, assuming A is safe (check in solve and go).

arc(take(X,Fi,Ff),state(F1,W1,G1,C1),state(F2,W2,G2,C2)):-
    (X=wolf,F1=Fi,W1=Fi,W2=Ff,F2=Ff,G2=G1,C2=C1,take(X,Fi,Ff),safe(state(F2,F2,G2,C2)));
    (X=goat,F1=Fi,G1=Fi,G2=Ff,F2=Ff,W2=W1,C2=C1,take(X,Fi,Ff),safe(state(F2,W2,F2,C2)));
    (X=cabbage,F1=Fi,C1=Fi,C2=Ff,F2=Ff,W2=W1,G2=G1,take(X,Fi,Ff),safe(state(F2,W2,G2,F2)));
    (X=none,F1=Fi,F2=Ff,W2=W1,G2=G1,C2=C1,take(X,Fi,Ff),safe(state(F2,W2,G2,C2))).

%GO: Method to tie up my results.

%this method checks for an indirect move from A to B via M.
% Visit is a list to store all the visited states in form of arc() terms (a list of arc calls).
go(A, B, Visit) :-
    safe(A),                            %always check for safety of A.
    Path = arc(take(_,_,_), A, M),      %Path searches a non-null path from A to M.
    \+ isMember(Path, Visit),           %check if Path is not in Visited list.
    Path,                               %check for a non-null Path.
    go(M, B, [Path|Visit]).             % prepend Path to Visit and recurse to find path from M to B.

%this method checks for an direct move from A to B.
go(A, B, Visit) :-
    safe(A),                            
    Path = arc(_, A, B),
    \+ isMember(Path, Visit),
    Path,
    print_path([Path|Visit]),   %method call to print the current visited path.
    !.

print_path([]).         %base case for print (empty null path).

print_path([arc(take(Object,Bank1, Bank2), _, _)|T]) :-
    print_path(T),                                          %print in reverse order to get the first path and then print in correct order as Visit is stored backwards.
    print('take('),print(Object),print(','),print(Bank1),print(','), print(Bank2),print(')'), nl.
    
%check for safe(A) and then call go to get the path, (empty visit as no path so far).
solve(F1,W1,G1,C1,F2,W2,G2,C2) :- safe(state(F1,W1,G1,C1)),go(state(F1,W1,G1,C1), state(F2,W2,G2,C2), []), !.  