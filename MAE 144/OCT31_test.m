%%%%%Test Root Locus and Bode Plot

s = tf('s')
G = (s+0.3)/((s+2)*(s+10)*s^2)



figure(1)
bode(G)

figure(2)
rlocus(G,Ks)