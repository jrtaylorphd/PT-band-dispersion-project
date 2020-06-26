
clear
warning off all;

AMP     = 1

% BEC PARAMETERS
hbar    = 1;
g1      = 1;   % g1 < 0 for focusing cubic term
g2      = -1   % g2 < 0 for focusing dipolar term

% POTENTIAL PARAMETERS
POTENT  = 'HAR';
V0      = 1;
kappa   = 1; % increasing kappa makes the potential more confined along the z axis

% CREATE GRIDS
% rmax is roughly based on the variational theory for a symmetric harmonic potential, 
% but may need tweaking based on the output
rmax    = 8*sqrt((2*hbar^2 + AMP*(g1+g2))/V0)
zmax    = 5*rmax/kappa;
Nr      = 32;
Build_new;

% TRAPPING POTENTIAL      
V_fun   = @(R,Z) (V0/2)*(R.^2 + ( kappa*Z ).^2);
V       = V_fun(R,Z);
   
% AITEM PARAMETERS
DT  = 0.5;
c   = 0.7 + max(abs(V(:)));
tol = 1e-5; % tolerance for residual

tic

[u LAP varphi_tilde mu_vec RES_vec L2_vec] = ...
    AITEM_3d_cyl(hbar,g1,g2,AMP,V,dr,dz,R,Z,K2,KS,DFTmat,iDFTmat,Hank,iHank,DT,c,tol);     

time_AITEM = toc

% PLOT mode and convergence
graphmode(u,R,Z,varphi_tilde,RES_vec,L2_vec,mu_vec);

% RECOVER CHARACTERISTICS
mu      = mu_vec(end);
L2      = L2_vec(end);
[FWHM_r FWHM_z] = fwhm(R,Z,u);
[E_V KE E_cub E_dip Hamil] = Hamiltonian(hbar,g1,g2,u,V,LAP,varphi_tilde,dr,dz,R);

disp(sprintf(['E_V=%0.3g KE=%0.3g E_cub=%0.3g E_dip=%0.3g Hamil=%0.3g mu=%0.3g FWHM_r=%0.3g FWHM_z=%0.3g'], ...
             E_V,KE,E_cub,E_dip,Hamil,mu,FWHM_r,FWHM_z));
    
