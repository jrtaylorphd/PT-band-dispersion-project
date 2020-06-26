
function graphmode(U,R,Z,varphi_tilde,RES_vec,L2_vec,mu_vec);

ind    = 1:(length(RES_vec)-1);
L2_rat = abs(L2_vec(ind+1)./L2_vec(ind) - 1);
mu_rat = abs(mu_vec(ind+1)./mu_vec(ind) - 1);
r      = R(1,1:end);
z      = Z(1:end,1);
Nz     = length(z);

subplot 221
mesh(R,Z,abs(U));
view([-60 20]);
axis tight;
title('$|\psi|$','interpreter','latex','fontsize',18);

subplot 222
mesh(R,Z,abs(varphi_tilde));
view([-60 20]);
axis tight;
title('$|\tilde\varphi|$','interpreter','latex','fontsize',18);

subplot 234
semilogy(ind,RES_vec(2:end),'-b',ind,mu_rat,'--r',ind,L2_rat,':g','linewidth',2);
grid on;
h = legend('residual','$\mu_{ratio}$','$L^2_{ratio}$','bestoutside');
set(h,'interpreter','latex','fontsize',14,'position',[0.16 0.36 0.16 0.13]);

%subplot 337
%plot(L2_vec);
%title('$\|\psi\|_2^2$','interpreter','latex','fontsize',18);

subplot 235
semilogy(r,abs(varphi_tilde(Nz/2+1,:)));
title('$|\tilde\varphi(r,0)|$','interpreter','latex','fontsize',18);

subplot 236
semilogy(z,abs(varphi_tilde(:,1)));
title('$|\tilde\varphi(0,z)|$','interpreter','latex','fontsize',18);

drawnow; shg;
 