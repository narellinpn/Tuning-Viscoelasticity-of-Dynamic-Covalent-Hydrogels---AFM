function all_fits_SR_lsqcurvefit(data,name,i)
       
    % Measured data from Stress Relaxation
    Normalized_Stress_G_all = data.Normalized_Stress;
    Stress_Original = data.Stress;
    Step_time_all = data.StepTime;
        
    %%Ignore first 20s of data:
    DataUse = find(Step_time_all>=20);
    Step_time = Step_time_all(DataUse);
    Normalized_Stress_G = Normalized_Stress_G_all(DataUse);
    length_axes = length(Step_time);
    
    % Set initial guess for the model parameters
    p_init_Sticky_Rouse = [1 1 1]; %(F tau_0 tau_s), Sticky_Rouse
    
    p_init_R = [1 1]; %(F tau_0), ROUSE
     
    % Set initial guess for the model parameters
    p_init_SLS_1 = [1 1 1];

    % Set initial guess for the model parameters
    p_init_SLS_2 = [1 1 1 1 1]; %(A, B, C, tau_1, tau_2), SLS 2-term     

    % Find minima of cost function. Note the LowPassFilter model function has been used
    %Calculating R_squared for all fits
    SStotal = TotalSumSquares(Normalized_Stress_G);

    %Defining options for probing optimization process
    options=optimset('Display','iter','PlotFcns',@optimplotfval,'MaxFunEvals',100000000,'MaxIter',100000000);
 
    %SLS-1 term
    [p_fit_SLS_1,fval_SLS_1,residuals_SLS_1,exitflag_SLS_1,output_SLS_1] = lsqcurvefit(@SLS_relax_Funct,p_init_SLS_1,Step_time, Normalized_Stress_G, [],[], options);
    %Evaluate model using the optimum parameters obtained above 
    time_fit_SLS =  Step_time;
    relax_fit_SLS = SLS_relax_Funct(p_fit_SLS_1, time_fit_SLS);

    %SLS-1 term evaluate goodness of fit through R^2
    Rsq_SLS_1 = 1 - fval_SLS_1/SStotal;
    p_fit_SLS_1(end+1) = Rsq_SLS_1;
    
    %SLS-2 term
    [p_fit_SLS_2,fval_SLS_2,residuals_SLS_2,exitflag_SLS_2,output_SLS_2] = lsqcurvefit(@SLS_Generalized_relax_Funct,p_init_SLS_2,Step_time, Normalized_Stress_G, [],[], options);
    %Evaluate model using the optimum parameters obtained above 
    time_fit_SLS_2 =  Step_time;
    relax_fit_SLS_2 = SLS_Generalized_relax_Funct(p_fit_SLS_2, time_fit_SLS_2);

    %SLS-2 term evaluate goodness of fit through R^2
    Rsq_SLS_2 = 1 - fval_SLS_2/SStotal;
    p_fit_SLS_2(end+1) = Rsq_SLS_2;

    %Sticky Rouse and Rouse take into account the size of HA so taking that
    %into account
    if contains(name,'20')
        SR_function_handle = @Sticky_rouse_Function_20kDa;
        R_function_handle = @Rouse_Function_20kDa;
    elseif contains(name,'40')
        SR_function_handle = @Sticky_rouse_Function_40kDa;
        R_function_handle = @Rouse_Function_40kDa;
    elseif contains(name,'60')
        SR_function_handle = @Sticky_rouse_Function;
        R_function_handle = @Rouse_Function;
    elseif contains(name,'100')
        SR_function_handle = @Sticky_rouse_Function_100kDa;
        R_function_handle = @Rouse_Function_100kDa;
    elseif contains(name,'500')
        SR_function_handle = @Sticky_rouse_Function_500kDa;
        R_function_handle = @Rouse_Function_500kDa;
    end
   
    %Rouse
    [p_fit_R,fval_R,residuals_R, exitflag_R,output_R] = lsqcurvefit(R_function_handle,p_init_R,Step_time, Normalized_Stress_G, [],[], options);
    %Evaluate model using the optimum parameters obtained above 
    time_fit_Rouse =  Step_time; 
    relax_fit_Rouse = R_function_handle(p_fit_R, time_fit_Rouse);

    % Rouse evaluate goodness of fit through R^2
    Rsq_R = 1 - fval_R/SStotal;
    p_fit_R(end+1) = Rsq_R;

    %Sticky Rouse
    [p_fit_SR,fval_SR,residuals_SR,exitflag_SR,output_SR] = lsqcurvefit(SR_function_handle,p_init_Sticky_Rouse,Step_time, Normalized_Stress_G, [],[],options);
    %Evaluate model using the optimum parameters obtained above 
    time_fit_Sticky_Rouse = Step_time;
    relax_fit_Sticky_Rouse = SR_function_handle(p_fit_SR, time_fit_Sticky_Rouse);

    %Sticky Rouse evaluate goodness of fit through R^2
    Rsq_SR = 1 - fval_SR/SStotal;
    p_fit_SR(end+1) = Rsq_SR;
      
   %Saving the calculated x and y values in a table to plot on Prism
    all_fits_SR_table_transposed = [time_fit_Sticky_Rouse,relax_fit_Sticky_Rouse, time_fit_Rouse,relax_fit_Rouse,time_fit_SLS, relax_fit_SLS,time_fit_SLS_2,relax_fit_SLS_2];
    all_fits_SR_array = [Step_time, Normalized_Stress_G,all_fits_SR_table_transposed];
    all_fits_SR_table = array2table(all_fits_SR_array);
    all_fits_SR_table.Properties.VariableNames = ["Time"; "Normalized Stress";"Time Sticky Rouse"; "Stress Sticky Rouse";...
        "Time Rouse"; "Stress Rouse";"Time SLS 1-Term"; "Stress SLS 1-Term"; "Time SLS 2-Term"; "Stress SLS 2-Term"];
    filename = append(name," - All Fits.xls");
    writetable(all_fits_SR_table, filename);

    %Saving the calculated fit coefficients + Rsquares in a table
    p_values_table = transposeArray_for_4_tables(p_fit_SR,p_fit_R,p_fit_SLS_1, p_fit_SLS_2);
    filename_coeff = append(name," - Coefficients.xls");
    p_values_table.Properties.VariableNames = ["Coeff Sticky Rouse"; "Coeff Rouse"; "Coeff SLS 1-term"; "Coeff SLS 2-term"];
    writetable(p_values_table, filename_coeff);

    % Plot the results in dB on a log scale
    figure(i)
    P_Ori_data = semilogx(Step_time,Normalized_Stress_G,'bo');
    hold on
    P_SR = semilogx(time_fit_Sticky_Rouse,relax_fit_Sticky_Rouse,'m--');
    P_R=semilogx(time_fit_Rouse,relax_fit_Rouse,'g--');
    P_SLS_1=semilogx(time_fit_SLS,relax_fit_SLS,'k--');
    P_SLS_2=semilogx(time_fit_SLS_2,relax_fit_SLS_2,'c--');
    
    xlabel('Step time (s)')
    ylabel('Normalized Stress')
    ylim([min(Normalized_Stress_G) max(Normalized_Stress_G)])
    title(name)
    set(P_SR(1),'LineWidth',2);
    set(P_Ori_data(1),'MarkerSize',2);
    set(P_R(1),'LineWidth',2);
    set(P_SLS_1(1),'LineWidth',2);
    set(P_SLS_2(1),'LineWidth',2);
    legend('Measured Data','Sticky Rouse Model Fit', 'Rouse Model Fit', 'SLS Model', ...
    'SLS Model 2 term')
    
end
