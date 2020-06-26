
clear;

g1       = 1;
g2       = 1;
kappa    = 2;
f_dir    = ['./AITEM_azimuthal_data/g1=',fstring(g1),'_g2=',fstring(g2),'_kappa=',fstring(kappa)];

CHOICE   = 'V0'
switch CHOICE
    case 'amplitude'
        AMP_vec  = [0.1 1];
        AMP_size = length(AMP_vec);
        V0       = 1;
        
        for ind_AMP = 1:length(AMP_vec);
            AMP     = AMP_vec(ind_AMP);
            f_load  = [f_dir,'/AMP=',fstring(AMP),'.mat'];
            
            if exist(f_load)
                % disp(['loading ',f_load]);
                load(f_load);
            else
                disp(['skipping ',f_load,' because it does not exist'])
            end
            
            FWHM_r_all(ind_AMP) = FWHM_r;
            FWHM_z_all(ind_AMP) = FWHM_z;
            L2_all(ind_AMP)     = L2_vec(end);
            mu_all(ind_AMP)     = mu_vec(end);
            EV_all(ind_AMP)     = E_V;
            KE_all(ind_AMP)     = KE;
            E_cub_all(ind_AMP)  = E_cub;
            E_dip_all(ind_AMP)  = E_dip;
            Hamil_all(ind_AMP)  = Hamil;
            
        end
        save(['./results/varying_AMP/azimuthal_compiled_g1=',fstring(g1),'_g2=',fstring(g2),'_kappa=',fstring(kappa),'.mat'], ...
             'hbar','g1','g2','V0','kappa','POTENT','rmax','Nr','DT','c','tol','*all');


    case 'V0'
        V0_vec  = [0.1:0.25:1.1];
        V0_size = length(V0_vec);
        AMP     = 1;
        
        for ind_V0 = 1:length(V0_vec);
            V0      = V0_vec(ind_V0);
            f_load  = [f_dir,'/V0=',fstring(V0),'.mat'];
            if exist(f_load)
                % disp(['loading ',f_load]);
                load(f_load);
            else
                disp(['skipping ',f_load,' because it does not exist'])
            end
            
            FWHM_r_all(ind_V0) = FWHM_r;
            FWHM_z_all(ind_V0) = FWHM_z;
            L2_all(ind_V0)     = L2_vec(end);
            mu_all(ind_V0)     = mu_vec(end);
            EV_all(ind_V0)     = E_V;
            %KE_all(ind_V0)     = KE;
            E_cub_all(ind_V0)  = E_cub;
            E_dip_all(ind_V0)  = E_dip;
            Hamil_all(ind_V0)  = Hamil;
        end
        save(['./results/varying_V0/azimuthal_compiled_g1=',fstring(g1),'_g2=',fstring(g2),'_kappa=',fstring(kappa),'.mat'], ...
             'hbar','g1','g2','V0_vec','kappa','POTENT','rmax','Nr','DT','c','tol','*all');


end %switch
plot_compare;
