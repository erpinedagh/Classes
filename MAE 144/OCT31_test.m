%%%%%Test Root Locus and Bode Plot

s = tf('s');
G = (s+0.5)/((s+5)*(s+10)*s^2);help 
Ks=[0:0.1:5000];


figure(1)
[G_MAG, G_PHASE,W ]= bode(G);
bode(G)

figure(2)
[L_root, L_K] = rlocus(G,Ks);
rlocus(G,Ks)

stable_ome = W(G_PHASE> -180.5);

cutoff = stable_ome(end);

