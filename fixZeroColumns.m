% fixes all columns with all-zeros to make each value 1/n for that column
function B = fixZeroColumns(L)
    B = L;
    toAdd = 1/length(L); % 1/n
    % find sum of columns, obtain the index of those that are 0
    colSum = sum(L);
    zeroColIndex = find(~colSum);
    zeroColIndex = zeroColIndex.';
    % take the indexes of the 0-columns and add 1/n to them
    for i=1:length(zeroColIndex)
        B(:,zeroColIndex(i)) = toAdd;
    end
end