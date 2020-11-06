% returns 1(true) if stochastic and 0(false) otherwise
function state = checkifStochastic(L)
    state = true;
    lenCount = length(L);
    colSum = sum(L); % sum every column to get 1xlenCount sum vector
    stochasticSum = sum(colSum); % sum every term of colSum vector
    % if stochastic, every column summed should equal 1, then sum of
    % columns equals the number of columns
    if lenCount ~= stochasticSum
        state = false;
    end
end