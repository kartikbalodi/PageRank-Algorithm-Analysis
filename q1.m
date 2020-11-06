% created dummy matrix for testing
L = [0 .5 .5 0; .5 0 .5 0; 0 .5 0 .5; .25 .25 .25 .25];
L = L.';

x = calcImportanceVector(L);
disp(x);
