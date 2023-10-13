
clear all 
clc
syms z1 p1
Ds = RR_tf([z1], [-2, -4, p1], 22);
Cs = zpk([z1], [-2, -4, p1], 22);

ome = 1;
causexp = "strict"; 
EP_C2D_match( Ds, ome, causexp)

c2d(Cs, 1, 'matched')

%%EP_C2D_match and c2d() only matches when you call strictly proper