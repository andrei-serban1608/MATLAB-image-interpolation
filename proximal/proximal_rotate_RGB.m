function out = proximal_rotate_RGB(img, rotation_angle)
    % =========================================================================
    % Aplica Interpolarea Proximala pentru a roti o imagine RGB cu un unghi dat.
    % =========================================================================

   % Am extras cele 3 canale ale imaginii
    R = img(:, :, 1);
    G = img(:, :, 2);
    B = img(:, :, 3);
    % Am aplicat functia proximal pe cele 3 canale ale imaginii.
    chR = proximal_rotate(R, rotation_angle);
    chG = proximal_rotate(G, rotation_angle);
    chB = proximal_rotate(B, rotation_angle);
    % Am format imaginea finala concatenand cele 3 canale de culori.
    out = cat(3, chR, chG, chB);
endfunction
