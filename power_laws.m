switch CHOICE
  
  case 'amplitude'

     slope_L2Hamil    = polyfit(log(L2_all),log(Hamil_all),1);
     slope_L2Hamil    = slope_L2Hamil(1);
     slope_muL2       = polyfit(log(mu_all),log(L2_all),1);
     slope_muL2       = slope_muL2(1);
     slope_HamilFWHMr = polyfit(log(Hamil_all),log(FWHM_r_all),1);
     slope_HamilFWHMr = slope_FWHMr(1);
     slope_HamilFWHMz = polyfit(log(Hamil_all),log(FWHM_z_all),1);
     slope_HamilFWHMz = slope_FWHMz(1);

     Titles   = {'Hamil vs L2';'L2 vs mu';'FWHM_r vs Hamil';'FWHM_z vs Hamil'};
     Slopes   = [slope_L2Hamil;slope_muL2;slope_HamilFWHMr;slope_HamilFWHMz];
     Property = table(Slopes,'RowNames',Titles)
  
  case 'V0'

     slope_Hamil = polyfit(log(V0_vec),log(Hamil_all),1);
     slope_Hamil = slope_Hamil(1);
     slope_L2 = polyfit(log(V0_vec),log(L2_all),1);
     slope_L2 = slope_L2(1);
     slope_FWHMr = polyfit(log(V0_vec),log(FWHM_r_all),1);
     slope_FWHMr = slope_FWHMr(1);
     slope_FWHMz = polyfit(log(V0_vec),log(FWHM_z_all),1);
     slope_FWHMz = slope_FWHMz(1);

     slope_EV   = polyfit(log(V0_vec),log(EV_all),1);
     slope_EV   = slope_EV(1);
     slope_Ecub = polyfit(log(V0_vec),log(E_cub_all),1);
     slope_Ecub = slope_Ecub(1);
     slope_Edip = polyfit(log(V0_vec),log(E_dip_all),1);
     slope_Edip = slope_Edip(1);

     Titles   = {'Hamil';'L2';'FWHM_r';'FWHM_z'};
     Slopes   = [slope_Hamil;slope_L2;slope_FWHMr;slope_FWHMz];
     Property = table(Slopes,'RowNames',Titles)
     
     clear Titles Slopes
     
     Titles   = {'EV';'E_cub';'E_dip'};
     Slopes   = [slope_EV;slope_Ecub;slope_Edip];
     Energy   = table(Slopes,'RowNames',Titles)

  case 'amplitude'



end
   
