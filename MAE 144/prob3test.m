
clear all 
clc
Ds = RR_tf([-1, -3], [-2, -4, -6, -8, -10], 22);
Cs = zpk([-1, -3], [-2, -4, -6, -8, -10], 22);

ome = 1;
causexp = "strict"; 
EP_C2D_match( Ds, ome)

c2d(Cs, 1, 'matched')