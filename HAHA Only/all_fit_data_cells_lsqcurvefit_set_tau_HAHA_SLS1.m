function all_fit_data_cells_lsqcurvefit_set_tau_HAHA_SLS1(dataCell,name)
%Making name into string array for later
name = string(name);

%Loop through each file inside the data cells 
for i = 1:numel(dataCell)

    % Read the data from the Excel file and store it in the cell array
    data = dataCell{i};
    var_names = convertCharsToStrings(data(1,:));
    data_to_fit = cell2table(data(2:end,:));
    data_to_fit.Properties.VariableNames = var_names;
    runNumber = sprintf(" - run %d",i)
    currentName = append(name,runNumber);
    all_fits_lsqcurvefit_MultiStart_SLS_1_only_set_tau_HAHA(data_to_fit,currentName,i);

end
