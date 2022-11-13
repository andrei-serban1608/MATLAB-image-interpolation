function out = proximal_2x2(f, STEP = 0.1)
    % ===================================================================================
    % Aplica Interpolare Proximala pe imaginea 2 x 2 f cu puncte intermediare echidistante.
    % f are valori cunoscute �n punctele (1, 1), (1, 2), (2, 1) ?i (2, 2).
    % Parametrii:
    % - f = imaginea ce se va interpola;
    % - STEP = distan?a dintre dou? puncte succesive.
    % ===================================================================================

    % Am definit coordonatele x si y ale punctelor intermediare.
    x_int = 1 : STEP : 2;
    y_int = 1 : STEP : 2;
    % Se afl? num?rul de puncte.
    n = length(x_int);

    % Cele 4 puncte �ncadratoare vor fi aceleasi pentru toate punctele din interior.
    x1 = 1;
    x2 = 2;
    y1 = 1;
    y2 = 2;
    % Am initializat rezultatul cu o matrice nula n x n.
    out = zeros(n,n);
    % Se parcurge fiecare pixel din imaginea finala.
    for i = 1 : n
        for j = 1 : n
            % Am aflat cel mai apropiat pixel din imaginea initiala.
            if j <= n / 2
              y = y1;
            else
              y = y2;
            endif
            if i <= n / 2
              x = x1;
            else
              x = x2;
            endif
            % Am calculat pixelul din imaginea finala.
            out(i, j) = f(x, y);
        endfor
    endfor

endfunction
