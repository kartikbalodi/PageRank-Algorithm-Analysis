% Link matrix A
A = [0 0 1/5 0 0 0 0 0 0 0 0 0;
    1 0 1/5 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1/2 0 0 0 0 0;
    0 0 1/5 0 1/2 0 0 0 0 0 0 0;
    0 0 1/5 0 0 0 0 0 0 0 0 0;
    0 0 1/5 0 0 0 0 0 0 0 0 0;
    0 0 0 1 1/2 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1/2 0 1 0 0 0;
    0 0 0 0 0 0 0 1 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 1 0;
    0 0 0 0 0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 0 0 1 0 0];
B = fixZeroColumns(A);
disp("B"); disp(B);

alpha = 0.9; N = 12;
u = 1/N*ones(N, 1);
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0.5; N = 12;
u = 1/N*ones(N, 1);
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0.1; N = 12;
u = 1/N*ones(N, 1);
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0.05; N = 12;
u = 1/N*ones(N, 1);
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0.01; N = 12;
u = 1/N*ones(N, 1);
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0.005; N = 12;
u = 1/N*ones(N, 1);
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0.001; N = 12;
u = 1/N*ones(N, 1);
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);


function printPageRankResults(C,alpha,u)
    fprintf('At alpha = %d and u = \n', alpha); disp(u.');
    disp("C(u,a)="); disp(C);
    tic
    [rnkAsc,importanceAsc,~,iterations] = pageRank(C);
    time = toc;
    fprintf('Time taken: %d\n', time);
    fprintf('# of iterations(rate of convergence comparison): %d\n', iterations);
    rnkDes = flip(rnkAsc, 2);
    importanceDes = flip(importanceAsc, 2);
    fprintf("Websites by importance (most to least):\n");
    for i=1:length(rnkDes)
        fprintf("%d.\tWebsite: %d\tImportance %d\n", i, rnkDes(i), importanceDes(i));
    end
    fprintf("\n");
end
