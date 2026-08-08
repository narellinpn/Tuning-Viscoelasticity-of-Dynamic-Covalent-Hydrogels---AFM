function processRelaxationFiles(folderPath)
    % processRelaxationFiles Processes .xls files containing 'Relaxation' in the name.
    %
    % For each file, it:
    %   1. Extracts the 'Stress' column.
    %   2. Calculates the average of the first 300 values of 'Stress'.
    %   3. Adds a new column 'Normalized Stress' with normalized values.
    %   4. Saves the modified file with '_normalized' appended to the name.
    %
    % Inputs:
    %   folderPath - The folder where the .xlsx files are stored
    
    % Get a list of all .xlsx files that contain 'Relaxation' in the filename
    filePattern = fullfile(folderPath, '*relaxation*.xlsx');  
    xlsFiles = dir(filePattern);

    % Loop through each file
    for k = 1:length(xlsFiles)
        % Get the current file name
        baseFileName = xlsFiles(k).name;
        fullFileName = fullfile(folderPath, baseFileName);

        % Read the data from the Excel file into a table
        data = readtable(fullFileName);

        % Check if the file contains the 'Stress' column
        if ismember('Stress', data.Properties.VariableNames)
            % Extract the 'Stress' column
            stressColumn = data.Stress;
            timeColumn = data.StepTime;
            
            %Getting index of time past 1 seconds
            indexes = (timeColumn >=1);
            stressColumn_Avg = stressColumn(indexes);
            StepTime = timeColumn(indexes);
            

            % Calculate the average of the first 10 values (or fewer if there aren't 10)
            to_avg = stressColumn_Avg(1:min(10, length(stressColumn_Avg)));
            avgStress = mean(to_avg);

            % Create the 'Normalized Stress' column by normalizing with respect to the average
            normalizedStress = stressColumn_Avg / avgStress;

            %Smoothing the curves
            normalizedStress_Smoothed = smoothdata(normalizedStress,"movmean", [10 10]); 

            % Add the 'Normalized Stress' column to the table
            dataNew = table(StepTime, normalizedStress_Smoothed);
            dataNew.Properties.VariableNames = ["StepTime","Normalized_Stress"];

            % Create a new file name with '_normalized' appended to the original name
            newFileName = fullfile(folderPath, [erase(baseFileName, '.xls') '_normalized.xls']);

            % Write the updated table back to a new Excel file
            writetable(dataNew, newFileName);

            % Display a message for tracking
            fprintf('Processed file: %s\n', newFileName);
        else
            % Display a message if the 'Stress' column is not found
            fprintf('File "%s" does not contain a "Stress" column.\n', baseFileName);
        end
    end
end
