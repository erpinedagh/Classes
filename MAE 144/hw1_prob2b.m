%hw1_prob2b
clc
clear all

s = [-1,-1,-3,-3,-6,-6,-20, -20, -20, -20, -20, 20];
f = RR_poly(s,1);
a = RR_poly([1,-1,3,-3,6,-6], 1);
b = RR_poly([-2,2,5,-5],1);
[x, y] = RR_diophantine(a,b,f);

    %After 5 additional poles at s = -20, D(s) now become proper with 
% poles = zeros = 5
    %After 6 additional poles at s = -20 to T(s), D(s) now becomes strictly
%proper with poles = 7 and zeros = 5

