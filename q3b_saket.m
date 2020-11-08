load('incidencematrix.mat');

M = addPage(M);
rnkDes = getCMatrix(M);

% Initializing visited vector, keeps track of visited pages
% Prevents adding same page twice
visited = zeros(1001, 1)';
visited(1001) = 1;
curr_pos = 1001;

% This method resolves in $987,849
% Adds least costly pages first (Pages with cost to add of < $1000)
% while curr_pos > 967
%   M = addConnection(1001, rnkDes(curr_pos), M);
% 	rnkDes = getCMatrix(M);
% 	cost = cost + (1000 - rnkDes(curr_pos) + 1)^2;
% 	if getRank(1001, rnkDes) > 0.1*length(M)
%         break
% 	end
% end  
% Adds new pages until the goal position is reached
% while getRank(1001, rnkDes) > 0.1*length(M)
%     M = addPage(M);
%     M = addConnection(1001, length(M), M);
%     rnkDes = getCMatrix(M);
%     cost = cost + 1000;
% end
% cost


% Greedy Algorithm - runs in $441,095
% Ranks each possible move by rank gained over cost
% Chooses most efficient move based on highest rank gained over cost
cost = 0;
while getRank(1001, rnkDes) > 0.1*length(M)
    greatest_step = -1;
    greatest_step_index = -1;
    currRank = getRank(1001, rnkDes);
    for i = 1:length(visited)
        currRank = getRank(1001, rnkDes);
        if visited(i) == 0
            A = M;
            A = addConnection(1001, i, A);
            rnkDes = getCMatrix(A);
            theoretical_cost = (1000 - i + 1)^2;
            rank_cost_ratio = (getRank(1001, rnkDes) - currRank)/theoretical_cost;
            if rank_cost_ratio > greatest_step
                greatest_step = rank_cost_ratio;
                greatest_step_index = i;
            end
        end
    end
    
    A = M;
    A = addPage(A);
    A = addConnection(1001, length(A), A);
    rnkDes = getCMatrix(A);
    theoretical_cost = 1000;
    rank_cost_ratio = (getRank(1001, rnkDes) - currRank)/theoretical_cost;
    
    if rank_cost_ratio > greatest_step
        M = addPage(M);
        M = addConnection(1001, length(M), M);
        visited(length(M)) = 1;
        cost = cost + 1000;
        rnkDes = getCMatrix(M);
    else
        visited(greatest_step_index) = 1;
        M = addConnection(1001, greatest_step_index, M);
        rnkDes = getCMatrix(M);
        cost = cost + (1000 - greatest_step_index + 1)^2;
    end
end
print(cost)



% This method operates with $72,000
% Only adding new webpages
% cost = 0
% while getRank(1001, rnkDes) > 0.1*length(M)
%     M = addPage(M);
%     M = addConnection(1001, length(M), M);
%     rnkDes = getCMatrix(M);
%     cost = cost + 1000;
% end
% cost


% This method operates with $80,416
% This methood adds the least costly method at each position (pure cost, no
% consideration for rrank)
% cost = 0
% while getRank(1001, rnkDes) > 0.1*length(M)
%     curr_cost = (1000 - curr_pos + 1)^2;
%     if curr_cost > 1000
%         M = addPage(M);
%         M = addConnection(1001, length(M), M);
%         cost = cost + 1000;
%         visited = [visited, 1];
%     else
%         if rnkDes(curr_pos) == 1001 || visited(rnkDes(curr_pos)) == 1
%             curr_pos = curr_pos - 1;
%             continue;
%         else
%             visited(rnkDes(curr_pos)) = 1;
%             M = addConnection(1001, rnkDes(curr_pos), M);
%             curr_pos = curr_pos - 1;
%             cost = cost + curr_cost;
%         end
%     end
%     rnkDes = getCMatrix(M);
% end
% getRank(1001, rnkDes)
% cost

%Helper function made by Kartik to get the rnkDes vector
function rnkDes = getCMatrix(M)
    A = M;
    A = normalizeCols(A);
    B = fixZeroColumns(A);
    alpha = 0.95;
    N = length(A);
    u = 1/N*ones(N, 1);
    C = removeCyclicPaths(B, u, alpha);
    [rnkAsc,~,~,~] = pageRank(C);
    rnkDes = flip(rnkAsc, 2);
end

%Helper function made to add connection from page j to page i in matrix A
function A = addConnection(i, j, A)
    if A(i, j) == 0
        A(i, j) = 1;
    end
end

%Helper function to add a page to matrix A
function B = addPage(A)
    B = A;
    B(length(A) + 1, length(A) + 1) = 0;
end

%Helper function made by Kartik to normalize columns of matrix A
function A = normalizeCols(A)
    colSum = sum(A); % sum of elements in every column
    % normalize column vector elements so their sum-by-column adds up to 1
    for i = 1:length(colSum)
        if colSum(i) % if sum of column vector elements > 0
            A(:,i) = A(:,i)/colSum(i); % normalize column vector to get A
        end
    end
end

%Helper function made to get the current rank of webpage n
function x = getRank(n, A)
    for i = 1:length(A)
        if A(i) == n
            x = i;
        end
    end
end
