% takes in Link Matrix L and returns 
% 1) array of ranking by importance of each page in ascending order
% 2) array of corresponding sorted importance for each ranked page
% 3) array of unsorted importance where the index of array corresponds to
%    each website and its respective importance
% uses calcImportanceVector function as helper
function [pageRankAsc,sortedImportanceAsc,importanceVector] = pageRank(L)
    % obtain importance for each website, total = 1
    importanceVector = calcImportanceVector(L);
    x = importanceVector.';
    % create key-value map of importance as key and website index as value
    % so that the map is sorted by key(importance)in ASCENDING order
    [sortedImportanceAsc,pageRankAsc] = sort(x);
end

% note: L must be a stochastic matrix for this function to work
%       if not, use makeStochastic function first (defined below)
function x = calcImportanceVector(L)
    websiteCount = length(L);
    %initialize x0 by giving equal importance to each webpage
    x0 = ones(websiteCount, 1)/websiteCount;
    x = x0;
    normComparison = norm(L*x-x, 2);
    % repeat steps till norm of Ax=x to 1e-10 closeness based on norm
    while normComparison > 1e-10
        x = L*x;
        normComparison = norm(L*x-x, 2);
    end
end