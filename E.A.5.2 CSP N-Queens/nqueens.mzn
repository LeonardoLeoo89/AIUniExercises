% --- Parametri di input ---
int: n_nodes;                                 % Numero di vertici
int: n_edges;                                 % Numero di archi
array[1..n_edges, 1..2] of 1..n_nodes: edges; % Lista degli archi (coppie di nodi)

% --- Variabili di decisione ---
% Ogni arco ha un colore associato (1, 2 o 3)
array[1..n_edges] of var 1..3: edge_color;

% --- Struttura di supporto ---
% Matrice di adiacenza che memorizza l'indice dell'arco tra due nodi.
% Utile per recuperare velocemente la variabile colore associata a una coppia di nodi.
array[1..n_nodes, 1..n_nodes] of 0..n_edges: adj = 
    array2d(1..n_nodes, 1..n_nodes, [
        let {
            % Cerca se esiste un arco tra i e j nella lista edges
            int: e = max([ if (edges[k,1] == i /\ edges[k,2] == j) \/ 
                              (edges[k,1] == j /\ edges[k,2] == i) 
                           then k else 0 endif | k in 1..n_edges ])
        } in e
    | i, j in 1..n_nodes ]);

% --- Vincoli ---
% Per ogni possibile tripla di nodi (i, j, k), se formano un triangolo,
% i colori dei tre archi non possono essere tutti uguali.
constraint forall(i, j, k in 1..n_nodes where i < j /\ j < k) (
    let {
        int: e1 = adj[i, j],
        int: e2 = adj[j, k],
        int: e3 = adj[k, i]
    } in
    if e1 > 0 /\ e2 > 0 /\ e3 > 0 then
        not (edge_color[e1] == edge_color[e2] /\ edge_color[e2] == edge_color[e3])
    else
        true
    endif
);

% --- Obiettivo ---
solve satisfy;

% --- Output ---
output [
    "Arco \(e) (\(edges[e,1])-\(edges[e,2])): Colore \(edge_color[e])\n"
    | e in 1..n_edges
];