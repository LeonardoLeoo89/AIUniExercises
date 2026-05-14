int: P;
int: G;
int: W;

array[1..P, 1..W] of var 1..G: X;

constraint forall(v in 1..G)(
    forall(j in 1..W)(
        sum(i in 1..P)(X[i,j] == v) == P div G
    )
);

constraint forall(i1, i2 in 1..P where i1 < i2)(
    forall(j1, j2 in 1..W where j1 < j2)(
        X[i1,j1] == X[i2,j1] -> X[i1,j2] != X[i2,j2]
    )
);

solve satisfy;

output [
    if j == 1 then "Giocatore " ++ show(i) ++ ":\t" else "" endif ++
    show(X[i,j]) ++ 
    if j == W then "\n" else "\t" endif
    | i in 1..P, j in 1..W
];