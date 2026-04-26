function objects = region_props(label_matrix, num_labels)
    objects = struct('label', {}, 'area', {}, 'bbox', {}, 'centroid', {});

    for k = 1:num_labels
        % find all pixels belonging to this label
        [rows, cols] = find(label_matrix == k);

        area     = numel(rows);
        centroid = [mean(cols), mean(rows)];   % [x, y]
        bbox     = [min(cols), min(rows), ...  % [x, y, width, height]
                    max(cols) - min(cols) + 1, ...
                    max(rows) - min(rows) + 1];

        objects(k).label    = k;
        objects(k).area     = area;
        objects(k).centroid = centroid;
        objects(k).bbox     = bbox;
    end
end
