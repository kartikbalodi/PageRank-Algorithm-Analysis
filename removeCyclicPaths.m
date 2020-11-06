% B = nxn matrix and ensure u is nx1 upon input and sum(u)=1
function C = removeCyclicPaths(B, u, alpha)
    e = ones(length(B), 1);
    C = alpha*B + (1-alpha)*u*e.';
end