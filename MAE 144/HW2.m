%%%%HW2
s = tf('s');
M = 1;
w = 1;
K = 1;
D = K*(s+1)/(s+10);
G = 12/M/(w*s)^2;
L = D*G;
Ks = [0:0.0001:10000];
figure(1)
T = (s+2.58)/(s+38.7);
bode(G, D, L,T);
rlocus(L)

legend("G", "LEAD", "L", "TARGET")