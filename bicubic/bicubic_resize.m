function R = bicubic_resize(I, p, q)
    % =========================================================================
    % Se scaleaza imaginea folosind algoritmul de Interpolare Bicubic?.
    % Transforma imaginea I din dimensiune m x n in dimensiune p x q.
    % =========================================================================

    [m n nr_colors] = size(I);
    I = double(I);
    % Initializez matricea finala drept o matrice nula.
    R = zeros(p, q);
    % daca imaginea e alb negru, ignora
    if nr_colors > 1
        R = -1;
        return
    endif

    % Obs:
    % Atunci cand se aplica o scalare, punctul (0, 0) al imaginii nu se va deplasa.
    % In Octave, pixelii imaginilor sunt indexati de la 1 la n.
    % Daca se lucreaza in indici de la 1 la n si se inmulteste x si y cu s_x
    % respectiv s_y, atunci originea imaginii se va deplasa de la (1, 1) la (sx, sy)!
    % De aceea, trebuie lucrat cu indici in intervalul [0, n - 1]!

    % Am calculat factorii de scalare
    % Obs: Daca se lucreaza cu indici in intervalul [0, n - 1], ultimul pixel
    % al imaginii se va deplasa de la (m - 1, n - 1) la (p, q).
    % s_x nu va fi q ./ n
    s_x = (q - 1) / (n - 1);
    s_y = (p - 1) / (m - 1);

    % Definesc matricea de transformare pentru redimensionare.
    T = [s_x 0; 0 s_y];
    % Am calculat inversa transformarii.
    T_inv = [1/s_x 0; 0 1/s_y];
    % Precalculez derivatele.
    [Ix, Iy, Ixy] = precalc_d(I);
    % Parcurge fiecare pixel din imagine.
    for y = 0 : p - 1
        for x = 0 : q - 1
            % Am aplicat transformarea inversa asupra (x, y) si calculeaza x_p si y_p
            % din spatiul imaginii initiale.
            v = T_inv * [x y]';
            x_p = v(1);
            y_p = v(2);
            % Am trecut (xp, yp) din sistemul de coordonate 0, n - 1 in
            % sistemul de coordonate 1, n pentru a aplica interpolarea.
            x_p = x_p + 1;
            y_p = y_p + 1;
            % Am calculat cele 4 puncte ce inconjoara punctul x, y
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
            % Am calculat coeficientii de interpolare A.
            A = bicubic_coef(I, Ix, Iy, Ixy, x1, y1, x2, y2);
            % Am trecut coordonatele (xp, yp) in patratul unitate, scazand (x1, y1).
            x_p = x_p - x1;
            y_p = y_p - y1;
            % Am calculat valoarea interpolata a pixelului (x, y).
            % Obs: Pentru scrierea in imagine, x si y sunt in coordonate de
            % la 0 la n - 1 si trebuie aduse in coordonate de la 1 la n.
            R(y + 1, x + 1) = [1 y_p y_p*y_p y_p*y_p*y_p] * A' * [1 x_p x_p*x_p x_p*x_p*x_p]';
        endfor
    endfor

    % Am transformat matricea transformata in uint8 pentru a fi o imagine valida.
    R = uint8(R);
endfunction





