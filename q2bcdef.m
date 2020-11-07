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

% Comment out respective sections to run each part separately
% part B
disp("B"); disp(B);

% part C,D
% alpha = 1; N = 12; NO CONVERGENCE AT ALPHA = 1 DUE TO CYCLES PRESENT
% u = 1/N*ones(N, 1);
% C = removeCyclicPaths(B, u, alpha);
% printPageRankResults(C,alpha,u);
alpha = 0.9; N = 12;
u = 1/N*ones(N, 1);
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0.7; N = 12;
u = 1/N*ones(N, 1);
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0.5; N = 12;
u = 1/N*ones(N, 1);
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0.3; N = 12;
u = 1/N*ones(N, 1);
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0.1; N = 12;
u = 1/N*ones(N, 1);
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0.01; N = 12;
u = 1/N*ones(N, 1);
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0.001; N = 12;
u = 1/N*ones(N, 1);
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0; N = 12;
u = 1/N*ones(N, 1);
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);

u = [1 0 0 0 0 0 0 0 0 0 0 0].';
fprintf('Testing for alpha = .95,.5,.05,0 while u = \n');
disp(u.');
alpha = .95;
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = .5;
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = .05;
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0;
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);

u = 1/2*[1 1 0 0 0 0 0 0 0 0 0 0].';
fprintf('Testing for alpha = .95,.5,.05,0 while u = \n');
disp(u.');
alpha = .95;
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = .5;
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = .05;
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0;
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);

u = 1/6*[1 1 1 1 1 1 0 0 0 0 0 0].';
fprintf('Testing for alpha = .95,.5,.05,0 while u = \n');
disp(u.');
alpha = .95;
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = .5;
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = .05;
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0;
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);

u = 1/6*[0 0 0 0 0 0 1 1 1 1 1 1].';
fprintf('Testing for alpha = .95,.5,.05,0 while u = \n');
disp(u.');
alpha = .95;
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = .5;
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = .05;
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);
alpha = 0;
C = removeCyclicPaths(B, u, alpha);
printPageRankResults(C,alpha,u);

% part E
alpha = -1; u = -1; % input any alpha and u for this part doesnt matter
printPageRankResults(A,alpha,u);

% part F
alpha = -1; u = -1; % input any alpha and u for this part doesnt matter
printPageRankResults(B,alpha,u);

% takes in C, u, alpha as input arguments and prints their order
% this function only print u, alpha without using it otherwise so
% to print B,A, set C to B,A and let u,alpha be any arbitray number/matrix.
function printPageRankResults(C,alpha,u)
    fprintf('At alpha = %d and u = \n', alpha); disp(u.');
    disp("C(u,a)="); disp(C);
    tic
    [rnkAsc,importanceAsc,~,iterations] = pageRank(C);
    time = toc;
    fprintf('alpha = %d\n', alpha);
    fprintf('Time taken: %d\n', time);
    fprintf('# of iterations(repeats for x=Cx): %d\n', iterations);
    rnkDes = flip(rnkAsc, 2);
    importanceDes = flip(importanceAsc, 2);
    fprintf("Websites by importance (most to least):\n");
    for i=1:length(rnkDes)
        fprintf("%d.\tWebsite: %d\tImportance %d\n", i, rnkDes(i), importanceDes(i));
    end
    fprintf("\n");
end

