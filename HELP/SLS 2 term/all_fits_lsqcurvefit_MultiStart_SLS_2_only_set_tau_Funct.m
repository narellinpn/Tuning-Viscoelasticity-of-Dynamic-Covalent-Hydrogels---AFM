function all_fits_lsqcurvefit_MultiStart_SLS_2_only_set_tau_Funct(data,name,i)
       
    % Measured data from Stress Relaxation
    Step_time_all = data.StepTime;
    Normalized_Stress_G_all = data.Normalized_Stress;
   
    %%Ignore first 20s of data:
    DataUse = find(Step_time_all>=1);
    Step_time = Step_time_all(DataUse);
    Normalized_Stress_G = Normalized_Stress_G_all(DataUse);
    length_axes = length(Step_time);
    
    % Set initial guess for the model parameters
    
    if contains(name,'20k')
            funct_MW=@SLS_relax_Funct_General_2_term_Set_Tau_20k_12h;

    elseif contains(name,'40k') 
            funct_MW=@SLS_relax_Funct_General_2_term_Set_Tau_40k_12h;

    elseif contains(name,'60k') 
            funct_MW=@SLS_relax_Funct_General_2_term_Set_Tau_60k_12h;

    elseif contains(name,'100k') 
            funct_MW=@SLS_relax_Funct_General_2_term_Set_Tau_100k_12h;

    elseif contains(name,'500k')
            funct_MW=@SLS_relax_Funct_General_2_term_Set_Tau_500k;

    elseif contains(name,'1000k')
            funct_MW=@SLS_relax_Funct_General_2_term_Set_Tau_1000k;
    end

    % Set initial guess for the model parameters
    p_init_SLS_1 = [1 1 1 1000];  %(A, B, C, tau_ep2) SLS 1-term

    % Find minima of cost function. Note the LowPassFilter model function has been used
    %Calculating R_squared for all fits
    SStotal = TotalSumSquares(Normalized_Stress_G);

    %Defining options for probing optimization process
    options=optimset('Display','iter','PlotFcns',@optimplotfval,'MaxFunEvals',100000000,'MaxIter',100000000);
 
    %SLS-1 term
    problem_SLS_1 = createOptimProblem('lsqcurvefit','x0',p_init_SLS_1,'objective',funct_MW,...
    'lb',[0, 0, 0, 0],'ub',[],'xdata',Step_time,'ydata',Normalized_Stress_G);
    
    ms = MultiStart('PlotFcns',@gsplotbestf,'Display','iter','UseParallel', true);

    [p_fit_SLS_1,fval_SLS_1,exitflag_SLS_1,output_SLS_1,solutions_SLS_1] = run(ms,problem_SLS_1,500);

    %Evaluate model using the optimum parameters obtained above 
    time_fit_SLS =  Step_time;
    relax_fit_SLS = funct_MW(p_fit_SLS_1, time_fit_SLS);

    %SLS-1 term evaluate goodness of fit through R^2
    Rsq_SLS_1 = 1 - (fval_SLS_1/SStotal);
    p_fit_SLS_1(end+1) = Rsq_SLS_1;
    
 
   %Saving the calculated x and y values in a table to plot on Prism
    all_fits_SR_table_transposed = [time_fit_SLS, relax_fit_SLS];
    all_fits_SR_array = [Step_time, Normalized_Stress_G,all_fits_SR_table_transposed];
    all_fits_SR_table = array2table(all_fits_SR_array);
    all_fits_SR_table.Properties.VariableNames = ["Time"; "Normalized Stress";"Time SLS 1-Term";"SLS 1-term"];
    filename = append(name," - All Fits - SLS 2 Only.xls");
    writetable(all_fits_SR_table, filename);

    %Saving the calculated fit coefficients + Rsquares in a table
    p_values_table = array2table(transpose(p_fit_SLS_1));
    filename_coeff = append(name," - Coefficients SLS 2 only.xls");
    p_values_table.Properties.VariableNames = "Coeff SLS 1-term";
    writetable(p_values_table, filename_coeff);

    % Plot the results in dB on a log scale
    figure(i)
    P_Ori_data = semilogx(Step_time,Normalized_Stress_G,'bo');
    hold on
    P_SLS_1=semilogx(time_fit_SLS,relax_fit_SLS,'k--');
    
    xlabel('Step time (s)')
    ylabel('Normalized Stress')
    ylim([min(Normalized_Stress_G) max(Normalized_Stress_G)])
    title(name)
    set(P_Ori_data(1),'MarkerSize',2);
    set(P_SLS_1(1),'LineWidth',2);
    legend('Measured Data','SLS Model')
    
end
