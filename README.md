This work is published at De Paiva Narciso N., Christakopoulos F., Huang M., Baugh N., Huerta-Lopez C., Matos E.X., Pashin K.P., Spakowitz A.J., Heilshorn S.C. “Tuning viscoelasticity of dynamic covalent hydrogels for human tissue modeling.” Accepted & In production. Advanced Functional Materials, 2026, 10.1002/adfm.76427

It is also at the Stanford Repository 	https://doi.org/10.25740/hg746sr4717.

HELP hydrogel System - One Polymer with LCST 

For the SLS 1 term fit

First you need to run the Free_MW_q_Fits_of_the_averages_12h.m, specifically for the q = 1, that is the DCC hydrogel system that in which the two polymers have the same size (matched).

Within it you will change the folder path to the specific averaged (n>=3 runs) normalized stress relaxation data in Time (s) and Stress (Pa) in an excel sheet - data MUST be pre-processed! 

This free fit will provide you with the characteristic relaxation time tau_0 that will be scaled by the Q factor for your formulations with mismatched polymer sizes. 

You will need to alter the function SLS_relax_Funct_General_1_term_Set_Tau_XXk_XXh.m with the specific tau value calculated from the q = MW_HA/ MW_ELP times the tau_0 which is the characteristic relaxation time obtained from the SLS-1 term free fit at q=1. Tau values will be in seconds.

If your stress relaxation was not performed at 10% strain, you will also need to alter the strain in each of the
SLS_relax_Funct_General_1_term_Set_Tau_XXk_XXh.m functions.

Once you have updated your values, you will need to run the Set_tau_MW_q_Fits_of_the_averages_12h.m, by updating the folder paths to your specific data, again all data must be normalized and pre-processed. 

All other functions are secondary to allow this system to be performed at multiple excel files within a folder at once.

This fitting system uses a MultiStart built-in function to test multiple 500 starting points and find a global solution - the properties of this are found on file all_fits_lsqcurvefit_MultiStart_SLS_1_only_set_tau.m

If the system fails to find a fit, change the p_init_SLS_1 array value and/or increase the number of runs in line 46.

As it processes, they will generate graphs so you can assess the fit.

After each analysis, the script creates two excel files:
- One contains all the coefficients of the fits as well as R^2 - for example: 20kDa HA 12% BZA @ 10% Strain - Set Tau - run 1 - Coefficients SLS 1 only.xls
- One contains the original data and fitted data - for example: 20kDa HA 12% BZA @ 10% Strain - Set Tau - run 1 - All Fits - SLS 1 Only.xls
 

For the SLS 2 term fit

You only need to run the Set_tau_Fits_of_the_averages_SLS2_12h_only.m file
Within it you will change the folder path to the specific averaged (n>=3 runs) normalized stress relaxation data in Time (s) and Stress (Pa) in an excel sheet - data MUST be pre-processed! 

You will need to alter the function SLS_relax_Funct_General_2_term_Set_Tau_XXk_XXh.m with the specific tau value calculated from the q = MW_HA/ MW_ELP times the tau_0 which is the characteristic relaxation time obtained from the SLS-1 term free fit at q=1. Tau values will be in seconds.

If your stress relaxation was not performed at 10% strain, you will also need to alter the strain in each of the
SLS_relax_Funct_General_2_term_Set_Tau_XXk_XXh.m functions.

All other functions are secondary to allow this system to be performed at multiple excel files within a folder at once.

This fitting system uses a MultiStart built-in function to test multiple 500 starting points and find a global solution - the properties of this are found on file all_fits_lsqcurvefit_MultiStart_SLS_2_only_set_tau_Funct.m

If the system fails to find a fit, change the p_init_SLS_1 array value and/or increase the number of runs in line 50.

As it processes, they will generate graphs so you can assess the fit.

After each analysis, the script creates two excel files:
- One contains all the coefficients of the fits as well as R^2 - for example: 20kDa HA 12% BZA - SLS 2 - Set Tau - run 1 - Coefficients SLS 2 only.xls
- One contains the original data and fitted data - for example: 20kDa HA 12% BZA - SLS 2 - Set Tau - run 1 - All Fits - SLS 2 Only.xls

HA Only hydrogel System - Polymers with no LCST 
For the SLS 1 term fit

First you need to run the Free_MW_q_Fits_of_the_averages_12h.m (in the HELP/SLS-1 Folder), specifically for the q = 1, that is the DCC hydrogel system that in which the two polymers have the same size (matched).

Within it you will change the folder path to the specific averaged (n>=3 runs) normalized stress relaxation data in Time (s) and Stress (Pa) in an excel sheet - data MUST be pre-processed! 

This free fit will provide you with the characteristic relaxation time tau_0 that will be scaled by the Q factor for your formulations with mismatched polymer sizes. 

You will need to alter the function SLS_relax_Funct_General_X_term_Set_Tau_HAHA_60k_hyd_XXk_12h.m with the specific tau value calculated from the q = MW_1/ MW_2 times the tau_0 which is the characteristic relaxation time obtained from the SLS-1 term free fit at q=1. Tau values will be in seconds.

If your stress relaxation was not performed at 10% strain, you will also need to alter the strain in each of the
SLS_relax_Funct_General_X_term_Set_Tau_HAHA_60k_hyd_XXk_12h.m functions.

Apply these changes to both your SLS1 and SLS 2 functions.

Once you have updated your values, you will need to run the Both_SLS_2_and SLS_1_set_tau_HAHA_controls_averages_12h.m, by updating the folder paths to your specific data, again all data must be normalized and pre-processed. 

All other functions are secondary to allow this system to be performed at multiple excel files within a folder at once.

This fitting system uses a MultiStart built-in function to test multiple 500 starting points and find a global solution - the properties of this are found on file all_fits_lsqcurvefit_MultiStart_SLS_1_only_set_tau_HAHA.m and all_fits_lsqcurvefit_MultiStart_SLS_2_only_set_tau_HAHA_control.m


If the system fails to find a fit, change the p_init_SLS_1 array value and/or increase the number of runs in the row: 
    [p_fit_SLS_1,fval_SLS_1,exitflag_SLS_1,output_SLS_1,solutions_SLS_1] = run(ms,problem_SLS_1,500);

As it processes, they will generate graphs so you can assess the fit.

After each analysis, the script creates two excel files:
- One contains all the coefficients of the fits as well as R^2 - for example: 20kDa HA 12% BZA @ 10% Strain - Set Tau - run 1 - Coefficients SLS 1 only.xls
- One contains the original data and fitted data - for example: 20kDa HA 12% BZA @ 10% Strain - Set Tau - run 1 - All Fits - SLS 1 Only.xls
 

