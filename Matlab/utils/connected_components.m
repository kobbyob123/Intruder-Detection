function [label_matrix, num_labels] = connected_components(bw)
    [rows, cols] = size(bw);
    label_matrix = zeros(rows, cols);
    num_labels = 0;

    % 8-connectivity neighbour offsets [row_offset, col_offset]
    neighbours = [-1,-1; -1,0; -1,1;
                   0,-1;        0,1;
                   1,-1;  1,0;  1,1];

    for i = 1:rows
        for j = 1:cols

            % only start a flood from an unlabelled foreground pixel
            if bw(i,j) == 1 && label_matrix(i,j) == 0

                num_labels = num_labels + 1;
                label_matrix(i,j) = num_labels;

                % BFS queue — each row is [row, col]
                queue = [i, j];

                while ~isempty(queue)
                    % pop from front
                    pixel = queue(1,:);
                    queue(1,:) = [];

                    % check all 8 neighbours
                    for k = 1:8
                        ni = pixel(1) + neighbours(k,1);
                        nj = pixel(2) + neighbours(k,2);

                        % bounds check, foreground check, unlabelled check
                        if ni >= 1 && ni <= rows && nj >= 1 && nj <= cols ...
                                && bw(ni,nj) == 1 && label_matrix(ni,nj) == 0

                            label_matrix(ni,nj) = num_labels;
                            queue(end+1,:) = [ni, nj]; % push to back
                        end
                    end
                end

            end
        end
    end
end
