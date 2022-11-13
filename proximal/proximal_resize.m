function R = proximal_resize(I, p, q)
    % =========================================================================
    % Se scaleaza imaginea folosind algoritmul de Interpolare Proximala.
    % Transforma imaginea I din dimensiune m x n �n dimensiune p x q.
    % =========================================================================
    [m n nr_colors] = size(I);
    I = double(I);
    % Se converteste imaginea de intrare la alb-negru, daca este cazul.
    if nr_colors > 1
        R = -1;
        return
    endif

    % Am initializat matricea finala cu zerouri
    R = zeros(p, q);
    % Obs:
    % Atunci c�nd se aplica o scalare, punctul (0, 0) al imaginii nu se va deplasa.
    % �n Octave, pixelii imaginilor sunt indexati de la 1 la n.
    % Daca se lucreaza cu indici de la 1 la n si se �nmultesc x si y cu s_x respectiv s_y,
    % atunci originea imaginii se va deplasa de la (1, 1) la (sx, sy)!
    % De aceea, trebuie lucrat cu indici �n intervalul [0, n - 1].

    % Obs: Daca se lucreaza cu indici din intervalul [0, n - 1], ultimul pixel
    % al imaginii se va deplasa de la (m - 1, n - 1) la (p, q).
    % s_x nu va fi q ./ n
    % Am calculat s_x si s_y corespunzator, conform indicatiilor
    s_x = (q - 1) / (n - 1);
    s_y = (p - 1) / (m - 1);
    % Initializez matricea de 2x2 de transformare T cu constantele de scalare in pozitiile bune
    T = zeros(2);
    T(1, 1) = s_x;
    T(2, 2) = s_y;
    % Am initializat inversa matricei de transformare T_inv direct cu valorile potrivite deoarece
    % este o matrice diagonala, astfel T_inv(i, i) = 1 / T(i, i)
    T_inv = zeros(2);
    T_inv(1, 1) = 1/s_x;
    T_inv(2, 2) = 1/s_y;
    % Se parcurge fiecare pixel din imagine.
    for y = 0 : p - 1
        for x = 0 : q - 1
            % Aplic transformarea inversa asupra (x, y) si calculeaza x_p si y_p
            % din spatiul imaginii initiale.
            v = [x; y];
            v_init = T_inv * v;
            % Trec (xp, yp) din sistemul de coordonate [0, n - 1] in
            % sistemul de coordonate [1, n] pentru a aplica interpolarea.
            v_init = v_init + 1;
            % Calculez cel mai apropiat pixel.
            v_init(1) = round(v_init(1));
            v_init(2) = round(v_init(2));
            % Calculez valoarea pixelului din imaginea finala.
            R(y + 1, x + 1) = I(v_init(2), v_init(1));
        endfor
    endfor

    % Transform matricea rezultata in uint8 pentru a fi o imagine valida.
    R = uint8(R);
endfunction
