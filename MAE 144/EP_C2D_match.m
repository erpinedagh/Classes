
function [Dz] = EP_C2D_match( Ds, omega_bar, caus )

    if nargin < 3
        caus = "semicaus";
    end

    for i  = 1 : length(Ds.z)
    zz(i) = exp(omega_bar * Ds.z(i));
    end

    for i  = 1 : length(Ds.p)
    zp(i) = exp(omega_bar* Ds.p(i));
    end
    
    prop = length(zp) - length(zz);
  
    if prop > 1
        for k = length(zz) + 1: length(zp)
            zz(k) = -1;
        end 
    end
        
    if caus== "strict"
            zz(end) = [] ;
    end

    Mz = RR_tf(zz, zp, 1);
    zGain = RR_evaluate(Ds,0) / RR_evaluate(Mz,1);
    Dz = RR_tf(zz, zp, zGain)

end

%TEST:
% Ds = RR_tf([-1, -3, -5], [-2, -4, -6, -8, -10]); ome = 1; causEXP = 'strict'; EP_C2D_match( Ds, ome, causEXP )



