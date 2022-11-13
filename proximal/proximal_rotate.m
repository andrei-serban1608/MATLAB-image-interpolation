function R = proximal_rotate(I, rotation_angle)
    % =========================================================================
    % Roteste imaginea alb-negru I de dimensiune m x n cu unghiul rotation_angle,
    % aplic�nd Interpolare Proximala.
    % rotation_angle este exprimat �n radiani.
    % =========================================================================
    [m n nr_colors] = size(I);
    I = double(I);
    % Se converteste imaginea de intrare la alb-negru, daca este cazul.
    if nr_colors > 1
        R = -1;
        return
    endif

    % Obs:
    % Atunci cand se aplica o scalare, punctul (0, 0) al imaginii nu se va deplasa.
    % In Octave, pixelii imaginilor sunt indexati de la 1 la n.
    % Daca se lucreaza in indici de la 1 la n si se inmultesc x si y cu s_x respectiv s_y,
    % atunci originea imaginii se va deplasa de la (1, 1) la (sx, sy)!
    % De aceea, trebuie lucrat cu indici in intervalul [0, n - 1].

    % Am calculat cosinus si sinus de rotation_angle.
    co = cos(rotation_angle);
    si = sin(rotation_angle);
    % Am initializat matricea finala.
    R = zeros(m, n);
    % Am calculat matricea de transformare.
    T = [co, -si; si, co];
    % Am inversat matricea de transformare, folosind functia inv
    inv_T = inv(T);
    % Se parcurge fiecare pixel din imagine.
    for y = 0 : m - 1
        for x = 0 : n - 1
            % Am aplicat transformarea inversa asupra (x, y) si am calculat x_p si y_p
            % din spatiul imaginii initiale.
            v = inv_T * [x; y];
            x_p = v(1);
            y_p = v(2);
            % Am trecut (xp, yp) din sistemul de coordonate [0, n - 1] in
            % sistemul de coordonate [1, n] pentru a aplica interpolarea.
            x_p = x_p + 1;
            y_p = y_p + 1;
            % Daca xp sau yp se afla in exteriorul imaginii,
            % se pune un pixel negru si se trece mai departe.
            if (x_p > n || x_p < 1 || y_p > m || y_p < 1)
              R(y + 1, x + 1) = 0;
              continue
            endif
            % Am aflat punctele ce inconjoara(xp, yp).
            % Am folosit functia floor pentru a aproxima valoarea
            % punctelor mai mici decat (x, y), adica partea intreaga,
            % iar pentru punctele mai mari am adaugat 1 la partile
            % intregi
            x1 = floor(x_p);
            y1 = floor(y_p);
            x2 = x1 + 1;
            y2 = y1 + 1;
            % Am verificat valorile din x1 si y1 pentru a ma asigura ca
            % pixelii nu ies din dimensiunile matricii
             if x2 > n
              x2 = n;
            endif
            if y2  > m
              y2 = m;
            endif
            % Am calculat coeficientii de interpolare notati cu a
            % Obs: Se poate folosi o functie auxiliara in care sau se calculeze coeficientii,
            % conform formulei.
            a = proximal_coef(I, x1, y1, x2, y2);
            % Am calculat valoarea interpolata a pixelului (x, y).
            % Readuc coordonatele din [0 n-1] la [1 n] si folosesc forma
            % modificata data in enunt
            R(y + 1, x + 1) = a(1) + a(2) * x_p + a(3) * y_p + a(4) * x_p * y_p;
        endfor
    endfor

    % TODO: Transforma matricea rezultata �n uint8 pentru a fi o imagine valida.
    R = uint8(R);
endfunction
