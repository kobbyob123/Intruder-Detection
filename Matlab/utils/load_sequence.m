function frames = load_sequence(folder)
    files = dir(fullfile(folder, '*.png'));
    frames = cell(1, numel(files));
    for i = 1:numel(files)
        img = imread(fullfile(folder, files(i).name));
        frames{i} = rgb_to_gray(img);   % your custom function
    end
end
