function extractStorageModulus(folderPath)
%% MATLAB script to process Excel sheets and extract specific data

% Initialize variables
outputFileName = append(folderPath,"\'Master_Storage_Modulus.xls");
dataSummary = {};
dataSummary{1, 1} = 'FileName';
dataSummary{1, 2} = 'StorageModulus_at_1rad_s';
dataSummary{1, 3} = 'LossModulus_at_1rad_s';
dataSummary{1, 4} = 'ComplexViscosity_at_1rad_s';

% Get a list of all .xlsx files that contain 'Relaxation' in the filename
filePattern = fullfile(folderPath, '*frequency sweep*.xlsx');
xlsFiles = dir(filePattern);

rowCounter = 2; % Start writing data from the second row

% Loop through each file
for k = 1:length(xlsFiles)
    % Get the current file name
    fileName = xlsFiles(k).name;
    fullFileName = fullfile(folderPath, fileName);

    % Read the data from the Excel file into a table
    data = readtable(fullFileName);

    % Check if required columns exist
    if all(ismember({'StorageModulus', 'AngularFrequency', 'LossModulus','ComplexViscosity'}, data.Properties.VariableNames))

        % Find the row where AngularFrequency equals 1.0
        idx = find(data.AngularFrequency == 1.0, 1);

        if ~isempty(idx)
            % Extract the corresponding StorageModulus value
            storageModulusValue = data.StorageModulus(idx);
            lossModulusValue = data.LossModulus(idx);
            ComplexViscosityValue = data.ComplexViscosity(idx);

            % Add to the summary
            dataSummary{rowCounter, 1} = fileName;
            dataSummary{rowCounter, 2} = storageModulusValue;
            dataSummary{rowCounter, 3} = lossModulusValue;
            dataSummary{rowCounter, 4} = ComplexViscosityValue;

            rowCounter = rowCounter + 1;
        end
    end
end

% Write the summary data to a new Excel file
if size(dataSummary, 1) > 1
    writecell(dataSummary, outputFileName);
    fprintf('Data has been successfully written to %s\n', outputFileName);
else
    fprintf('No matching data found to write to %s\n', outputFileName);
end

