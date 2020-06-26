
warning off all;
[~, host] = system('hostname')

%load taxi.mat            % load AMP
%unix('\rm -f taxi.mat'); % This allows taxi.m to proceed to the next job 

% static vector for all the runs that input_ind
% change the "t" values in mat.sub to run from 1 to length(AMP_vec)

CHOICE  = 'amplitude'
%CHOICE  = 'V0'

switch CHOICE
  case 'amplitude' 
    AMP_vec = [.1];
    AMP     = AMP_vec(input_ind);
  otherwise 
    AMP     = 1;
end


TIME_init = datetime('now')

% BEC PARAMETERS
hbar    = 1; 
g1      = 1;     % g1 < 0 for focusing cubic term
g2      = -1;    % g2 < 0 for focusing dipolar term

% POTENTIAL PARAMETERS
POTENT  = 'HAR';

switch CHOICE
  case 'V0' 
    V0_vec = [0.1];
    V0     = V0_vec(input_ind);
  otherwise
    V0      = .1;
end
kappa   = .25; % increasing kappa makes the potential more confined along the z axis

% CREATE GRIDS
if AMP > 1
rmax    = 8*sqrt(2)*hbar/ (V0*AMP*4);
else
rmax    = 8*sqrt(2)*hbar/ (V0*4);
end
zmax    = rmax/sqrt(kappa);
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

disp(sprintf('\n Running V0 = %g, AMP = %g, g1 = %g, g2 = %g, kappa = %d\n',V0,AMP,g1,g2,kappa))

[u LAP varphi_tilde mu_vec RES_vec L2_vec] = ...
    AITEM_3d_cyl(hbar,g1,g2,AMP,V,dr,dz,R,Z,K2,KS,DFTmat,iDFTmat,Hank,iHank,DT,c,tol);     

time_AITEM = toc

graphmode(u,R,Z,varphi_tilde,RES_vec,L2_vec,mu_vec);

% RECOVER CHARACTERISTICS
mu      = mu_vec(end);
L2      = L2_vec(end);
[FWHM_r FWHM_z] = fwhm(R,Z,u);
[E_V KE E_cub E_dip Hamil] = Hamiltonian(hbar,g1,g2,u,V,LAP,varphi_tilde,dr,dz,R);

disp(sprintf(['E_V=%0.3g KE=%0.3g E_cub=%0.3g E_dip=%0.3g Hamil=%0.3g mu=%0.3g FWHM_r=%0.3g FWHM_z=%0.3g\n'], ...
             E_V,KE,E_cub,E_dip,Hamil,mu,FWHM_r,FWHM_z))
    
TIME_end = datetime('now')

% SAVE 
f_dir = ['./AITEM_azimuthal_data/g1=',fstring(g1),'_g2=',fstring(g2),'_kappa=',fstring(kappa)];
if exist(f_dir,'dir') == 0
    mkdir(f_dir)
end;

switch CHOICE
  case 'amplitude' 
    disp(['saving ',f_dir,'/AMP=',fstring(AMP),'.mat'])
    clear R Z V K2 KS KZ *DFT* *Hank* varphi* LAP
    save([f_dir,'/AMP=',fstring(AMP),'.mat']);
  case 'V0' 
    disp(['saving ',f_dir,'/V0=',fstring(V0),'.mat'])
    clear R Z V K2 KS KZ *DFT* *Hank* varphi* LAP
    save([f_dir,'/V0=',fstring(V0),'.mat']);
 end
