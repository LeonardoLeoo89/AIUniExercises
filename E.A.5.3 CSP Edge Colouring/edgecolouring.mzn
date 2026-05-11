int: n;                            % Numero di nodi
array[1..n, 1..n] of bool: adj;    % Matrice di adiacenza

% Variabili: color[i,j] e' il colore dell'arco (i,j), 0 se non esiste
array[1..n, 1..n] of var 0..3: color;

constraint forall(i, j in 1..n where i < j) (
    if adj[i,j] then color[i,j] > 0 else color[i,j] == 0 endif
);

% Simmetria: (i,j) == (j,i)
constraint forall(i, j in 1..n) (
    color[i,j] == color[j,i]
);

constraint forall(i, j, k in 1..n where i < j /\ j < k) (
    (adj[i,j] /\ adj[j,k] /\ adj[k,i]) -> 
        not (color[i,j] == color[j,k] /\ color[j,k] == color[i,k])
);

solve satisfy;