function [U LAP varphi_tilde mu_vec RES_vec L2_vec] = ...
    AITEM_3d_cyl(hbar,g1,g2,AMP,V,dr,dz,R,Z,K2,KS,DFTmat,iDFTmat,Hank,iHank,DT,c,tol);     

% solve L00[U] = hbar*mu*U

% pre-conditioner operator
DEN      = -1./( hbar^2*K2/2 + c );

% Jacobian
J        = 2*pi*R*dr*dz;

% initial guess
U        = exp(-(R.^2 + Z.^2));

RES_vec  = 1;
mu2_vec  = 1;
n        = 0;
PLOT     = 0; 

if PLOT
    %figure('pos',[100 100 900 600]);
end

while RES_vec(end) > tol

    n     = n + 1;
    Uold  = U;
    
    % amplitude normalization
    U     = U*AMP/max(abs(U(:)));
    
    Ua2   = U.*conj(U);
    LAP   = real( iDFTmat*(-K2.*(DFTmat*U*Hank'))*iHank' );
    varphi_tilde = real( iDFTmat*(-KS.*(DFTmat*Ua2*Hank'))*iHank' ); 
    L00U  = -(hbar^2/2)*LAP + V.*U + ( (g1 - g2)*Ua2 - 3*g2*varphi_tilde ).*U; % note signs before g2
   
    MinvU = real( iDFTmat*(DEN.*(DFTmat*U*Hank'))*iHank' );
    mu    = sum(sum(J.*(L00U.*MinvU))) / sum(sum(J.*(U.*MinvU))) / hbar;
    U     = U + real(iDFTmat*(DEN.*(DFTmat*(L00U - hbar*mu*U)*Hank'))*iHank')*DT; 
     
    % monitor convergence
    RES_vec(n) = norm(L00U(:) - hbar*mu*U(:),'inf');
    L2_vec(n)  = sum(sum (U.*conj(U).*J) );
    mu_vec(n)  = mu;
    
    if PLOT & (mod(n,300) == 0)
        graphmode(U,R,Z,varphi_tilde,RES_vec,L2_vec,mu_vec);
    end
    
end