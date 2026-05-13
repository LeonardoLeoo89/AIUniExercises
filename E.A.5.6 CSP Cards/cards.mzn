include "alldifferent.mzn";
int: n;
int: k;
array[1..n, 1..k] of var 1..n*k: x;

constraint alldifferent(x);
constraint forall(i in 1..n, j in 2..k) (
    x[i,j] = x[i,j-1] + (i+1)
);
 

array[1..k*n] of var 1..n: sequence;
constraint forall(i in 1..n, j in 1..k)(
    sequence[x[i, j]] = i
);

solve satisfy;

output [show(sequence)];
