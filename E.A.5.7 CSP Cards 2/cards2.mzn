include "alldifferent.mzn";
int: N;
int: M;
int: D;
array[1..N] of int: Cards;
array[1..N] of var 1..M: X;
var 2..N-3: P1;
var 3..N-2: P2;
var 4..N-1: P3;

constraint forall(v in 1..M)(
    sum(i in 1..N)(X[i] == v) == sum(j in 1..N)(Cards[j] == v)
);

constraint P1 < P2 /\ P2 < P3;

constraint P3 - P1 == D;

constraint forall(i in 1..N-1) (
    (i < P1 -> X[i] < X[i+1]) /\
    (i >= P1 /\ i < P2 -> X[i] > X[i+1]) /\
    (i >= P2 /\ i < P3 -> X[i] < X[i+1]) /\
    (i >= P3 -> X[i] > X[i+1])
);

solve satisfy;

output [show(X)];
