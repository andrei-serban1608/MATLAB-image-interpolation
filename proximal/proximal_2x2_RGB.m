function out = proximal_2x2_RGB(img, STEP = 0.1)
    % ==============================================================================================
    % Aplica Interpolare Proximala pe imaginea 2 x 2 definita img cu puncte intermediare echidistante.
    % img este o imagine colorata RGB -Red, Green, Blue.
    % =============================================================================================

    % Am extras cele 3 canale ale imaginii
    R = img(:, :, 1);
    G = img(:, :, 2);
    B = img(:, :, 3);
    % Am aplicat functia proximal pe cele 3 canale ale imaginii.
    chR = proximal_2x2(R, STEP);
    chG = proximal_2x2(G, STEP);
    chB = proximal_2x2(B, STEP);
    % Am format imaginea finala concatenand cele 3 canale de culori.
    out = cat(3, chR, chG, chB);
endfunction
