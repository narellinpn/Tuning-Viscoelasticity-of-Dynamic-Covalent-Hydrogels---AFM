function Normalized_Stress_General_Compile_All_Together(inputFolder)
    % Process multiple Excel files to extract stress-related data.
    %
    % Parameters:
    %   inputFolder: Folder containing the Excel files.
    %   outputFile: Path to save the output Excel file = same folder as
    %   inputFolder
    outputFile = append(inputFolder,"\Normal_Compile_All.xls");
    
    % Get a list of all Excel files in the folder
    files = dir(fullfile(inputFolder, '*normalized*.xls'));
    numFiles = length(files);
    
    % Initialize a cell array to store the results
    results_names = strings;
    results_array = [];
    
    % Loop through each file
    for i = 1:numFiles
        % Get the full file path
        filePath = fullfile(files(i).folder, files(i).name);
        filename_long = files(i).name;
        % Text to remove
        textToRemove = 'Stress relaxation - 8x_normalized.xls';

        % Remove the text
        filename = strrep(filename_long, textToRemove, '');

        % Read the data from the Excel file (assuming two columns: time and stress)
        data = readtable(filePath);
        time = data.StepTime; % Assuming the time is StepTime column
        normStress = data.Normalized_Stress; % Assuming this is the name of the Normalized Stress column

        %%Ignore first 1s of data:
        DataUse = find(time>=1);
        Step_time = time(DataUse);
        Normalized_Stress_G = normStress(DataUse);
        
        %Adding colums
        time_name = append(filename,"_Time");
        if i == 1
            results_names(end) = time_name;
        else
            results_names(end+1) = time_name;
        end

        Stress_name = append(filename,"_Stress");
        results_names(end+1) = Stress_name;

        if i~=1
            if length(results_array) > length(Normalized_Stress_G)
                diff = (length(results_array) - length(Normalized_Stress_G));
                Step_time = padarray(Step_time,diff,0,'post');
                Normalized_Stress_G = padarray(Normalized_Stress_G,diff,0,'post');
            elseif length(results_array) < length(Normalized_Stress_G)
                diff = -(length(results_array) - length(Normalized_Stress_G));
                results_array = padarray(results_array,diff,0,'post');
            end
        end
       
        results_array(:,end+1) = Step_time;
        results_array(:,end+1) = Normalized_Stress_G;

    end
    %Calculate average from the normalized runs
    Avg = results_array(:, 2:2:end);
    Avg = mean(Avg,2);
    results_array(:,end+1) = Avg;
    results_names(end+1) = "Average Normalized Runs";

    % Write the results to a new Excel sheet
    results = array2table(results_array);
    results.Properties.VariableNames = results_names;
    writetable(results, outputFile);
    fprintf('Results saved to %s\n', outputFile);
end
