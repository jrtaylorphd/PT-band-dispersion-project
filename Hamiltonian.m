function [E_V KE E_cub E_dip Hamil] = Hamiltonian(hbar,g1,g2,U,V,LAP,varphi_tilde,dr,dz,R);

J      = 2*pi*R*dr*dz;      % Jacobian in real space
Ua2    = U.*conj(U); 

KE     = -hbar.^2/2 * sum(sum( LAP.*U.*J ));
E_V    = sum(sum( V.*Ua2.*J ));
E_cub  = g1/2 * sum(sum( Ua2.^2.*J ));
E_dip  = -g2/2 * sum(sum( (Ua2 + 3*varphi_tilde).*Ua2.*J ));
Hamil  = KE + E_V + E_cub + E_dip;
