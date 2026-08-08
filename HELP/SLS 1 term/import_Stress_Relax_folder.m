function dataCellArray = import_Stress_Relax_folder(folderPath)

% Get a list of all Excel files in the folder
filePattern = fullfile(folderPath, '*.xlsx');
excelFiles = dir(filePattern);

% Initialize a cell array to store data from each Excel file
dataCellArray = cell(1, numel(excelFiles));

% Loop through each Excel file and read its contents
for i = 1:numel(excelFiles)
    % Get the full path of the Excel file
    fileName = fullfile(excelFiles(i).folder, excelFiles(i).name);
    
    % Read the data from the Excel file and store it in the cell array
    dataCellArray{i} = readcell(fileName);
    
    % Optionally, display the progress
    %fprintf('Loaded %s\n', fileName);
end

% Output the result
disp('All Excel files have been loaded into the cell array.');
