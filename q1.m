%TESTING
L = [0 .5 .5 0; 
    .5 0 .5 0; 
    0 .5 0 .5; 
    .25 .25 .25 .25];
L = L.';

disp("Calculating for A");
check = checkifStochastic(L);
disp(check);
if check == 1
    [A,B,C] = pageRank(L);
    disp(A);
    disp(B);
    disp(C);
end