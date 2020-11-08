load('incidencematrix.mat');

M = addPage(M);
rnkDes = getCMatrix(M);

visited = zeros(1001, 1)';
visited(1001) = 1;
curr_pos = 1001;

%This method resolves in $987,849
% cost = 0;
% while curr_pos > 967
%     M = addConnection(1001, rnkDes(curr_pos), M);
% 	rnkDes = getCMatrix(M);
% 	cost = cost + (1000 - rnkDes(curr_pos) + 1)^2;
% 	if getRank(1001, rnkDes) > 0.1*length(M)
%         break
% 	end
% end  
% while getRank(1001, rnkDes) > 0.1*length(M)
%     M = addPage(M);
%     M = addConnection(1001, length(M), M);
%     rnkDes = getCMatrix(M);
%     cost = cost + 1000;
% end
% cost


%Greedy Algorithm - runs in $4983
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
    A = addConnection(1001, length(M), M);
    rnkDes = getCMatrix(A);
    theoretical_cost = 1000;
    rank_cost_ratio = (getRank(1001, rnkDes) - currRank)/theoretical_cost;
    
    if rank_cost_ratio > greatest_step
        a = "adding an edge"
        M = addPage(M);
        M = addConnection(1001, length(M), M);
        visited(length(M)) = 1;
        cost = cost + 1000;
        rnkDes = getCMatrix(M);
    else
        b = greatest_step_index
        visited(greatest_step_index) = 1;
        M = addConnection(1001, greatest_step_index, M);
        rnkDes = getCMatrix(M);
        cost = cost + (1000 - greatest_step_index + 1)^2;
    end
    
    the_rank = getRank(1001, rnkDes)
    cost
end



% This method operates with $72,000
% cost = 0
% while getRank(1001, rnkDes) > 0.1*length(M)
%     M = addPage(M);
%     M = addConnection(1001, length(M), M);
%     rnkDes = getCMatrix(M);
%     cost = cost + 1000;
% end
% cost


% This method operates with $80,416
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

function A = addConnection(i, j, A)
    if A(i, j) == 0
        A(i, j) = 1;
    end
end

function B = addPage(A)
    B = A;
    B(length(A) + 1, length(A) + 1) = 0;
end


function A = normalizeCols(A)
    colSum = sum(A); % sum of elements in every column
    % normalize column vector elements so their sum-by-column adds up to 1
    for i = 1:length(colSum)
        if colSum(i) % if sum of column vector elements > 0
            A(:,i) = A(:,i)/colSum(i); % normalize column vector to get A
        end
    end
end

function x = getRank(n, A)
    for i = 1:length(A)
        if A(i) == n
            x = i;
        end
    end
end
