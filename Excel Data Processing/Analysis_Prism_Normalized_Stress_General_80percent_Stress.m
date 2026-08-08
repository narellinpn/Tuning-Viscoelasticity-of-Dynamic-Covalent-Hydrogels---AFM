function Analysis_Prism_Normalized_Stress_General_80percent_Stress(inputFolder)
    % Process multiple Excel files to extract stress-related data.
    %
    % Parameters:
    %   inputFolder: Folder containing the Excel files.
    %   outputFile: Path to save the output Excel file = same folder as
    %   inputFolder
    outputFile = append(inputFolder,"\PrismAnalysis_85.xls");
    
    % Get a list of all Excel files in the folder
    files = dir(fullfile(inputFolder, '*normalized*.xls'));
    numFiles = length(files);
    
    % Initialize a cell array to store the results
    results = {'Filename', 'Last Time - 90% relax (s)', 'RunLengthTime (s)', 'Stress at 12h', 'Stress at 24h', 'Stress End'};
    
    % Loop through each file
    for i = 1:numFiles
        % Get the full file path
        filePath = fullfile(files(i).folder, files(i).name);
        
        % Read the data from the Excel file (assuming two columns: time and stress)
        data = readtable(filePath);
        time = data.StepTime; % Assuming the time is StepTime column
        normStress = data.Normalized_Stress; % Assuming this is the name of the Normalized Stress column

        % Find the last time where normalized stress > 0.85
        threshold = 0.85;
        lastTimeIdx = find(normStress >= threshold, 1, 'last');
      
        if ~isempty(lastTimeIdx)
            lastTime = time(lastTimeIdx);
        else
            lastTime = NaN;
        end
        
        % Find the stress at 12h (in seconds) and 24h (in seconds)
        stressAt12hIdx = find(time >= 12 * 3600, 1);
        stressAt24hIdx = find(time >= 24 * 3600, 1);
        stressAtEndIdx = find(time == max(time),1);

        stressAt12h = NaN; % Default to NaN if no data is found
        stressAt24h = NaN;
        stressAtEnd = NaN;

        if ~isempty(stressAt12hIdx)
            stressAt12h = normStress(stressAt12hIdx);
        end
        if ~isempty(stressAt24hIdx)
            stressAt24h = normStress(stressAt24hIdx);
        end
        if ~isempty(stressAtEndIdx)
            stressAtEnd = normStress(stressAtEndIdx);
            RunLengthTime = time (stressAtEndIdx);
        end

        % Add results to the cell array
        results(end+1, :) = {files(i).name, lastTime, RunLengthTime, stressAt12h, stressAt24h, stressAtEnd};
    end
    
    % Write the results to a new Excel sheet
    writecell(results, outputFile);
    fprintf('Results saved to %s\n', outputFile);
end
