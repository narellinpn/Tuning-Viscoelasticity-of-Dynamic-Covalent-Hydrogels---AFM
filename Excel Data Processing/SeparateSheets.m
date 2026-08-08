function SeparateSheets(folderPath) % Define the folder where the Excel files are stored
% Change this to your folder path

% Get a list of all Excel files in the folder
filePattern = fullfile(folderPath, '*.xls'); % For .xlsx files
excelFiles = dir(filePattern);

% Loop over each Excel file
for k = 1:length(excelFiles)
    % Get the current file name
    baseFileName = excelFiles(k).name;
    fullFileName = fullfile(folderPath, baseFileName);
    
    % Read the information about sheets in the current Excel file
    [~, sheets] = xlsfinfo(fullFileName);
    
    % Loop over each sheet
    for sheetIndex = 1:length(sheets)
        % Read data from the current sheet
        sheetName = sheets{sheetIndex};
        data = readtable(fullFileName, 'Sheet', sheetName);
        
        % Create a new file name by appending the sheet name to the base file name
        newFileName = fullfile(folderPath, [erase(baseFileName, '.xlsx') '_' sheetName '.xlsx']);
        
        % Save the data to a new Excel file
        writetable(data, newFileName);
        
        % Display a message for progress tracking
        fprintf('Saved sheet "%s" from file "%s" as "%s"\n', sheetName, baseFileName, newFileName);
    end
end
end