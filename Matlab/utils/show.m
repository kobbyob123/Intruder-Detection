function [] = show(varargin)
    numArgs = nargin;
    args = varargin;
    
    figure
    for k = 1 : numArgs
        subplot(1, numArgs, k)
        imshow(args{k})
    end
end
