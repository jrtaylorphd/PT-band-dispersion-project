
[r kr Hank iHank] = qdht(rmax,0,Nr);

dr      = abs(r(1) - r(2));

% choose dz approximately equal to dr
zmin    = -zmax;
Nz      = round((zmax-zmin)/dr)
if mod(Nz,2) == 1
    Nz = Nz+1; % ensure Nz is even, so that z(Nz/2+1) = 0
end
dz      = (zmax-zmin)/Nz;
z       = [zmin:dz:zmax-dz];

DFTmat  = dftmtx(Nz);
iDFTmat = conj(DFTmat)/Nz;

[R,Z]   = meshgrid(r,z);

dkz     = 2*pi/(zmax-zmin); 
kz      = fftshift([-Nz/2:Nz/2-1]*dkz);

[KR,KZ] = meshgrid(kr,kz);

K2      = KR.^2 + KZ.^2;
KS      = KZ.^2./K2;


