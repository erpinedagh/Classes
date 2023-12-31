
function [Dz] = EP_C2D_match( Ds, omega_bar, caus )

    for i  = 1 : length(Ds.z)
    zz(i) = exp(omega_bar * Ds.z(i));
    end

    for i  = 1 : length(Ds.p)
    zp(i) = exp(omega_bar* Ds.z(i));
    end
    
    prop = length(zp) - length(zz)
    %% for NON-causal sysm
    if prop > 1
        for k = length(zz) + 1: length(zp)
            zz(k) = -1;
        end 

        if caus == 'strict'
            zz(end) = [] ;
        end
    end
    
    Mz = RR_tf(zz, zp, 1)
    zGain = RR_evaluate(Ds,0) / RR_evaluate(Mz,1)
    Dz = RR_tf(zz, zp, zGain)

end


