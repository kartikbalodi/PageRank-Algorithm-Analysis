load('incidencematrix.mat');
A = M; %load matrix
colSum = sum(A); % sum of elements in every column
% normalize column vector elements so their sum-by-column adds up to 1
for i = 1:length(colSum)
    if colSum(i) % if sum of column vector elements > 0
        A(:,i) = A(:,i)/colSum(i); % normalize column vector to get A
    end
end

B = fixZeroColumns(A);
alpha = 0.95; N = length(A);
u = 1/N*ones(N, 1);
C = removeCyclicPaths(B, u, alpha);
printFirstTenPageRank(C);

% prints first 10 results of pagerank algorithm
function printFirstTenPageRank(C)
    tic
    [rnkAsc,importanceAsc,~,iterations] = pageRank(C);
    time = toc;
    fprintf('Time taken: %d\n', time);
    fprintf('# of iterations(repeats for x=Cx): %d\n', iterations);
    rnkDes = flip(rnkAsc, 2);
    importanceDes = flip(importanceAsc, 2);
    fprintf("Websites by importance (most to least):\n");
    for i=1:10
        fprintf("%d.\tWebsite: %d\tImportance: %d\n", i, rnkDes(i), importanceDes(i));
    end
    fprintf("\n");
end