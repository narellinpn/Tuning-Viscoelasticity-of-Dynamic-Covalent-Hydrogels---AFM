%Set tau with q Fits in SLS general 1 term
%Load all data
%Load all data
data_haha_60k=import_Stress_Relax_folder("C:\Users\narel\Documents\Stanford\Heilshorn Lab\Tiny Stool Project\revision experiments\Averages for Analysis\control ha 60k bza - ha 60k hyd");
data_haha_20k=import_Stress_Relax_folder("C:\Users\narel\Documents\Stanford\Heilshorn Lab\Tiny Stool Project\revision experiments\Averages for Analysis\control ha 20k bza - ha 60k hyd");
data_haha_500k=import_Stress_Relax_folder("C:\Users\narel\Documents\Stanford\Heilshorn Lab\Tiny Stool Project\revision experiments\Averages for Analysis\control ha 500k bza - ha 60k hyd");
data_haha_1000k=import_Stress_Relax_folder("C:\Users\narel\Documents\Stanford\Heilshorn Lab\Tiny Stool Project\revision experiments\Averages for Analysis\Control HA 1 MDa - HA 60k hyd");

%Fitting data to SLS-1 term set tau1 = tau_0*q
all_fit_data_cells_lsqcurvefit_set_tau_HAHA_SLS1(data_haha_20k, 'HAHA 60K hyd 20k bza - SLS 1 set tau');
all_fit_data_cells_lsqcurvefit_set_tau_HAHA_SLS1(data_haha_60k, 'HAHA 60K hyd 60k bza - SLS 1 set tau');
all_fit_data_cells_lsqcurvefit_set_tau_HAHA_SLS1(data_haha_500k, 'HAHA 60K hyd 500k bza - SLS 1 set tau');
all_fit_data_cells_lsqcurvefit_set_tau_HAHA_SLS1(data_haha_1000k, 'HAHA 60K hyd 1000k bza - SLS 1 set tau');


%Fitting data to SLS-2 term set tau1 = tau_0*q, no constraints tau_2
all_fit_data_cells_lsqcurvefit_set_tau_Funct_SLS_2_HAHA(data_haha_20k, 'HAHA 60K hyd 20k bza - SLS 2 set tau 1');
all_fit_data_cells_lsqcurvefit_set_tau_Funct_SLS_2_HAHA(data_haha_60k, 'HAHA 60K hyd 60k bza - SLS 2 set tau 1');
all_fit_data_cells_lsqcurvefit_set_tau_Funct_SLS_2_HAHA(data_haha_500k, 'HAHA 60K hyd 500k bza - SLS 2 set tau 1');
all_fit_data_cells_lsqcurvefit_set_tau_Funct_SLS_2_HAHA(data_haha_1000k, 'HAHA 60K hyd 1000k bza - SLS 2 set tau 1');
