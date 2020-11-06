% note: L must be a stochastic matrix for this function to work
%       if not, use makeStochastic function first (defined below)
function x = calcImportanceVector(L)
    webCount = length(L);
    %initialize x0 by giving equal importance to each webpage
    x0 = ones(webCount, 1)/webCount;
    x = x0;
    normComparison = norm(L*x-x, 2);
    % repeat steps till norm of Ax=x to 1e-10 closeness based on norm
    while normComparison > 1e-10
        x = L*x;
        normComparison = norm(L*x-x, 2);
    end
end