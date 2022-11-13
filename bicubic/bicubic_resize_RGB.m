function out = bicubic_resize_RGB(img, p, q)
    % =========================================================================
    % Redimensioneaza imaginea img astfel �nc�t aceasta save fie de dimensiune p x q.
    % Imaginea img este colorata.
    % =========================================================================

    % Am extras cele 3 canale ale imaginii
    R = img(:, :, 1);
    G = img(:, :, 2);
    B = img(:, :, 3);
    % Am aplicat functia proximal pe cele 3 canale ale imaginii.
    chR = bicubic_resize(R, p, q);
    chG = bicubic_resize(G, p, q);
    chB = bicubic_resize(B, p, q);
    % Am format imaginea finala concatenand cele 3 canale de culori.
    out = cat(3, chR, chG, chB);
endfunction
