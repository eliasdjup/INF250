% shows the data we will be focusing on
figure(1);
scatter(petals(:,1),petals(:,2),15);
title 'Fisher''s Iris Data';
xlabel 'Petal Length (cm)'; 
ylabel 'Petal Width (cm)';


rng(351); %for reproducibility
[idx,C] = kmeans(petals,2);
ex7a_0_show_clusters(petals, idx, C);

% larger cluster seems to be split into a lower variance region and a higher variance region
% kmeans uses the k-means++ algorithm for centroid initialization and squared Euclidean distance by default
% idx is a vector of predicted cluster indices corresponding to the observations in petals 
% C is a 3-by-2 matrix containing the final centroid locations
rng(351); %for reproducibility
[idx,C] = kmeans(petals,3);
% lets see the clustering result
ex7a_0_show_clusters(petals, idx, C);

% lets see what the algorithm does in the first iteration
rng(351); % empirically selected seed that produces the worst possible results
[idx,C] = kmeans(petals,3,'MaxIter',1);
ex7a_0_show_clusters(petals, idx, C);

% use C as starting points for the next iteration
% note run multiple times to get good results
[idx,C] = kmeans(petals,3,'MaxIter',1,'Start',C);
ex7a_0_show_clusters(petals, idx, C);


hold on




