function Just_All_Analysis_80percent_Relax(inputFolder)

%Splitting all the sheets
SeparateSheets(inputFolder);

%Normalizing the Stress
processRelaxationFiles(inputFolder);

%Getting the Storage Moduli
extractStorageModulus(inputFolder);

%Getting information for Prism Analysis
Analysis_Prism_Normalized_Stress_General_80percent_Stress(inputFolder);

%Joining all formalized runs in single file
Normalized_Stress_General_Compile_All_Together(inputFolder);

end

