% select starting points randomly
M=datasample(petals,3);
%[idx,C] = kmeans(petals,3,'MaxIter',1,'Start',M);
[idx,C] = kmeans(petals,3,'Start',M);
ex7a_0_show_clusters(petals, idx, M);

% select same starting points
M=[petals(1,:); petals(1,:); petals(1,:)];
%[idx,C] = kmeans(petals,3,'MaxIter',1,'Start',M);
[idx,C] = kmeans(petals,3,'Start',M);
ex7a_0_show_clusters(petals, idx, M);