s = tf('s');
K = 6;
LEAD = (s+1)/(s+4);
LAG = (s+0.20)/(s+0.04);

G = K*LEAD*LAG;


figure(1)
[G_MAG, G_PHASE,W ]= bode(G);
bode(G)

figure(2)
[L_root, L_K] = rlocus(G,Ks);
rlocus(G,Ks)