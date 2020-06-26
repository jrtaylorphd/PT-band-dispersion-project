
function [FWHM_r FWHM_z] = fwhm(R,Z,ua2);
    
r      = R(1,:);
z      = Z(:,1);
Nz     = length(z);
MAX    = max(ua2(:));

[tmp ind] = min( abs(ua2(Nz/2+1,:) - MAX/2) );
FWHM_r    = 2*r(ind);

[tmp ind] = min( abs(ua2(:,1) - MAX/2) );
FWHM_z    = 2*abs(z(ind));
