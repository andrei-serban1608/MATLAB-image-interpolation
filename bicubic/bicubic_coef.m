function A = bicubic_coef(f, Ix, Iy, Ixy, x1, y1, x2, y2)
    % =========================================================================
    % Calculeaz? coeficien?ii de Interpolare Bicubic? pentru 4 puncte al?turate
    % =========================================================================

    % Am calculat matricile intermediare.
    aux1 = [1 0 0 0; 0 0 1 0; -3 3 -2 -1; 2 -2 1 1];
    f_aux = [f(y1, x1) f(y1, x2); f(y2, x1) f(y2, x2)];
    Ix_aux = [Ix(y1, x1) Ix(y1, x2); Ix(y2, x1) Ix(y2, x2)];
    Iy_aux = [Iy(y1, x1) Iy(y1, x2); Iy(y2, x1) Iy(y2, x2)];
    Ixy_aux = [Ixy(y1, x1) Ixy(y1, x2); Ixy(y2, x1) Ixy(y2, x2)];
    aux2 = [f_aux Ix_aux; Iy_aux Ixy_aux];
    % Am convertit matricile intermediare la double.
    aux1 = double(aux1);
    aux2 = double(aux2);
    % Am calculat matricea finala.
    A = aux1 * aux2' * aux1';
endfunction
