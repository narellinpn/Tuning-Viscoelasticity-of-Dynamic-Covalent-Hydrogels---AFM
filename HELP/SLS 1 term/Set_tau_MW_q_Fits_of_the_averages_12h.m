%Set tau with q Fits in SLS general 1 term
%Load all data
%Load all data
data_20k_12BZA=import_Stress_Relax_folder('C:\Users\narel\Documents\Stanford\Heilshorn Lab\Tiny Stool Project\Data_From_fotis\Actually Used\Averages for matlab\12h Averages\20 kDa\12');
data_20k_20BZA=import_Stress_Relax_folder('C:\Users\narel\Documents\Stanford\Heilshorn Lab\Tiny Stool Project\Data_From_fotis\Actually Used\Averages for matlab\12h Averages\20 kDa\20');

data_40k_12BZA=import_Stress_Relax_folder('C:\Users\narel\Documents\Stanford\Heilshorn Lab\Tiny Stool Project\Data_From_fotis\Actually Used\Averages for matlab\12h Averages\40 kDa');

data_60k_6BZA=import_Stress_Relax_folder('C:\Users\narel\Documents\Stanford\Heilshorn Lab\Tiny Stool Project\Data_From_fotis\Actually Used\Averages for matlab\12h Averages\60 kDa\6');
data_60k_12BZA=import_Stress_Relax_folder('C:\Users\narel\Documents\Stanford\Heilshorn Lab\Tiny Stool Project\Data_From_fotis\Actually Used\Averages for matlab\12h Averages\60 kDa\12');
data_60k_20BZA=import_Stress_Relax_folder('C:\Users\narel\Documents\Stanford\Heilshorn Lab\Tiny Stool Project\Data_From_fotis\Actually Used\Averages for matlab\12h Averages\60 kDa\20');

data_100k_12BZA=import_Stress_Relax_folder('C:\Users\narel\Documents\Stanford\Heilshorn Lab\Tiny Stool Project\Data_From_fotis\Actually Used\Averages for matlab\12h Averages\100 kDa');

data_500k_6BZA=import_Stress_Relax_folder('C:\Users\narel\Documents\Stanford\Heilshorn Lab\Tiny Stool Project\Data_From_fotis\Actually Used\Averages for matlab\12h Averages\500 kDa\6');
data_500k_12BZA=import_Stress_Relax_folder('C:\Users\narel\Documents\Stanford\Heilshorn Lab\Tiny Stool Project\Data_From_fotis\Actually Used\Averages for matlab\12h Averages\500 kDa\12');
data_500k_20BZA=import_Stress_Relax_folder('C:\Users\narel\Documents\Stanford\Heilshorn Lab\Tiny Stool Project\Data_From_fotis\Actually Used\Averages for matlab\12h Averages\500 kDa\20');

data_1000k_12BZA=import_Stress_Relax_folder('C:\Users\narel\Documents\Stanford\Heilshorn Lab\Tiny Stool Project\Data_From_fotis\Actually Used\Averages for matlab\12h Averages\1000 kDa');

%all_fit_data_cells_lsqcurvefit_set_tau(data_20k_6BZA, '20kDa HA 6% BZA @ 10% Strain - Set Tau');
all_fit_data_cells_lsqcurvefit_set_tau(data_20k_12BZA, '20kDa HA 12% BZA @ 10% Strain - Set Tau');
all_fit_data_cells_lsqcurvefit_set_tau(data_20k_20BZA, '20kDa HA 20% BZA @ 10% Strain - Set Tau');

all_fit_data_cells_lsqcurvefit_set_tau(data_40k_12BZA, '40kDa HA 12% BZA @ 10% Strain - Set Tau');

all_fit_data_cells_lsqcurvefit_set_tau(data_60k_12BZA, '60kDa HA 12% BZA @ 10% Strain - Set Tau');
all_fit_data_cells_lsqcurvefit_set_tau(data_60k_6BZA, '60kDa HA 6% BZA @ 10% Strain - Set Tau');
all_fit_data_cells_lsqcurvefit_set_tau(data_60k_20BZA, '60kDa HA 20% BZA @ 10% Strain - Set Tau');

all_fit_data_cells_lsqcurvefit_set_tau(data_100k_12BZA, '100kDa HA 12% BZA @ 10% Strain - Set Tau');

all_fit_data_cells_lsqcurvefit_set_tau(data_500k_12BZA, '500kDa HA 12% BZA @ 10% Strain - Set Tau');
all_fit_data_cells_lsqcurvefit_set_tau(data_500k_6BZA, '500kDa HA 6% BZA @ 10% Strain - Set Tau');
all_fit_data_cells_lsqcurvefit_set_tau(data_500k_20BZA, '500kDa HA 20% BZA @ 10% Strain - Set Tau');

all_fit_data_cells_lsqcurvefit_set_tau(data_1000k_12BZA, '1000kDa HA 12% BZA @ 10% Strain - Set Tau');