%%
syms C_p C_fr s;
C_p_s = (1/(s * C_p));
C_fr_s = (1/(s * C_fr));
Z11 = ((C_p_s + C_fr_s) * C_p_s) / ((C_p_s + C_fr_s) + C_p_s);
Z11_s = s * Z11;
Z11_s = simplify(Z11_s);
[num,den] = numden(Z11_s);
Z11_s = num/den / (den/den);

%% SMA dummy short model
syms L_sma C_sma R_sma G_sma w;
L_sma_j = L_sma * 1j * w;
C_sma_j = 1 / (C_sma*1j*w);
Z11 = ((L_sma_j + R_sma) * C_sma_j) / ((L_sma_j + R_sma) + C_sma_j);
%Z11 = (Z11 * G_sma) / (Z11 + G_sma);