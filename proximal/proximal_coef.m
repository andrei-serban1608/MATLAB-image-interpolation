function a = proximal_coef(f, x1, y1, x2, y2)
    % =========================================================================
    % Calculeaza coeficientii a pentru Interpolarea Proximala intre punctele
    % (x1, y1), (x1, y2), (x2, y1) si (x2, y2).
    % =========================================================================

    % Am calculat matricea A conform formei din enunt
    A = [1, x1, y1, x1*y1; 1, x1, y2, x1*y2;  1, x2, y1, x2*y1; 1, x2, y2, x2*y2];
    % Analog, am calculat vectorul b
    b = [f(y1, x1); f(y2, x1); f(y1, x2); f(y2, x2)];
    % Am calculat coeficientii.
    a = A \ b;
endfunction
