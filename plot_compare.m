
if ~exist('g1');
    g1       = 1;
    g2       = -1;
    kappa    = .25;
    V0       = .1;
    POTENT   = 'HAR';
    CHOICE   = 'amplitude'
end



clf;
FONT = 18;

switch CHOICE

  case 'amplitude' 
    f_load   = ['./results/varying_AMP/azimuthal_compiled_g1=',fstring(g1),'_g2=',fstring(g2),'_kappa=',fstring(kappa),'_V0=',fstring(V0)];
    load([f_load,'.mat']);
    
    f1 = figure('pos',[100 100 900 600]); 
    subplot 221
    plot(L2_all,Hamil_all,'linewidth',2)
    title('(a)')
    xlabel('N','interpreter','latex','fontsize',FONT);
    ylabel('$E$','interpreter','latex','fontsize',FONT);

    subplot 222
    plot(mu_all,L2_all,'linewidth',2)
    title('(b)')
    xlabel('$\mu$','interpreter','latex','fontsize',FONT);
    ylabel('$N$','interpreter','latex','fontsize',FONT);
    
    figure('pos',[100 100 900 600]); 
    
    subplot 221
    plot(Hamil_all,smooth(FWHM_r_all),'linewidth',2)
    xlabel('$E$','interpreter','latex','fontsize',FONT);
    ylabel('radial FWHM','interpreter','latex','fontsize',FONT);

    subplot 222
    plot(Hamil_all,smooth(FWHM_z_all),'linewidth',2)
    xlabel('$E$','interpreter','latex','fontsize',FONT);
    ylabel('axial width','interpreter','latex','fontsize',FONT);
 
    shg;

    print(f1,['GenFig/figures/ENL2mu_wrt_AMP_g1=',fstring(g1),'_g2=',fstring(g2),'_kappa=',fstring(kappa),'.eps'],'-depsc');

  case 'V0'
    f_load   = ['./results/varying_V0/azimuthal_compiled_g1=',fstring(g1),'_g2=',fstring(g2),'_kappa=',fstring(kappa)];
    load([f_load,'.mat']); 
    
    figure('pos',[100 100 900 600]);
    subplot 231
    plot(V0_vec,Hamil_all,'linewidth',2)
    xlabel('$V_0$','interpreter','latex','fontsize',FONT);
    ylabel('$E$','interpreter','latex','fontsize',FONT);
    xlim([min(V0_vec) max(V0_vec)])
     
    subplot 232
    plot(V0_vec,L2_all,'linewidth',2)
    xlabel('$V_0$','interpreter','latex','fontsize',FONT);
    ylabel('$N$','interpreter','latex','fontsize',FONT);
    xlim([min(V0_vec) max(V0_vec)])
   
    subplot 233
    plot(V0_vec,smooth(FWHM_r_all),'linewidth',2)
    xlabel('$V_0$','interpreter','latex','fontsize',FONT);
    ylabel('radial FWHM','interpreter','latex','fontsize',FONT);
    xlim([min(V0_vec) max(V0_vec)])

    subplot 234
    plot(V0_vec,smooth(FWHM_z_all),'linewidth',2)
    xlabel('$V_0$','interpreter','latex','fontsize',FONT);
    ylabel('axial width','interpreter','latex','fontsize',FONT);
    xlim([min(V0_vec) max(V0_vec)])

    subplot 235
    plot(V0_vec,EV_all, V0_vec,E_cub_all, V0_vec, E_dip_all,'linewidth',2)
    legend('EV','E_c_u_b','E_d_i_p')
    xlabel('$V_0$','interpreter','latex','fontsize',FONT);
    ylabel('E components','interpreter','latex','fontsize',FONT);
    xlim([min(V0_vec) max(V0_vec)])
    shg;

    print([f_load,'_wrt_V0.eps'],'-depsc');

    power_laws

end

