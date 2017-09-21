%%
syms C w G R L
syms Z0 g l

Z1 = ((2/G)*(1/1i*w*C) / ((2/G) + (1/1i*w*C)));
%Z1 = 2 / (2*1i*w*C + G);
Z3 = Z1;
Z2 = R + 1i*w*L;

%%
Z_11 = (Z1*(Z2 + Z3)) / (Z1 + Z2 + Z3);
Z_12 = (Z1 * Z3) / (Z1 + Z2 + Z3);

Z_11_tline = Z0 / ((g*l - (g*l)^3 / 3 + 2*(g*l)^5 / 15));
Z_12_tline = Z0 / ((g*l + (g*l)^3 / 3*2 + (g*l)^5 / 5*4*3*2));

g_RLGC_relation = g == sqrt((R + 1i*w*L) * (G + 1i*w*C));
Z0_LC_relation = Z0 == sqrt((R + 1i*w*L)/(G + 1i*w*C));

sol = solve([Z_11 == Z_11_tline, Z_12 == Z_12_tline, g_RLGC_relation, Z0_LC_relation], [R, G, L, C], 'IgnoreAnalyticConstraints', true);

%%
limit(sol.C, l, 0)
limit(sol.L, l, 0)
limit(sol.G, l, 0)
limit(sol.R, l, 0)