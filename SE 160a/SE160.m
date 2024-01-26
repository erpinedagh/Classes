
K = [24 -12 0; -12 12 -12; 0 -12 23];
F = [8;0;6];
A= inv(K)*F

B = [40 5 0; 5 10 0; 0 0 31];controcontrol
eig(B)
