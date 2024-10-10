function deleteCsvFiles(directoryPath)
    % Check if the input is a valid directory
    if ~isfolder(directoryPath)
        error('Input is not a valid directory.');
    end
    
    % Define the file pattern to match .csv files
    filePattern = fullfile(directoryPath, '**', '*.csv');
    
    % Get a list of all .csv files in the specified directory and subdirectories
    csvFiles = dir(filePattern);
    
    % Iterate through the list and delete each .csv file
    for i = 1:numel(csvFiles)
        filePath = fullfile(csvFiles(i).folder, csvFiles(i).name);
        delete(filePath);
        fprintf('Deleted: %s\n', filePath);
    end
    
    fprintf('Deletion of .csv files completed.\n');
end
