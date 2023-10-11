%%HW1_PROB2a    
clear all
s = [-1,-1,-3,-3,-6,-6];
f1 = RR_poly(s,1);
a = RR_poly([1,-1,3,-3,6,-6], 1);
b = RR_poly([-2,2,5,-5],1);
[x1, y1] = RR_diophantine(a,b,f1);
%% Test to make sure that 
test1=trim(a*x1+b*y1), residual1=norm(f1-test1)


