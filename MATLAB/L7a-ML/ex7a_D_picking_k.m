data = petals;

k = 1;
m = max(var(data)); % we use variance to estimate the starting distance
changes = [];
while m > 0.2 % use 0.2 for showing the example
    k=k+1
    [idx,C] = kmeans(data,k);
    
    means = [];
    for n = 1:k
        xp = C(n,1);
        yp = C(n,2);
        cdata = data(idx==n,:);
        means = [means, mean(sqrt((cdata(:,1)-xp).^2 + (cdata(:,2)-yp).^2))];
    end
    changes = [changes, m-max(means)];
    m = max(means);
    ex7a_0_show_clusters(data, idx, C);
    pause;
end

% plots the amout of changes in average distance
plot(changes)

% so we pick a value that is closed to the knee of the curve
[idx,C] = kmeans(data,3);
ex7a_0_show_clusters(data, idx, C);


% https://www.mathworks.com/help/stats/silhouette.html
% The silhouette value for each point is a measure of how similar that point is to points in its own cluster, 
% when compared to points in other clusters. The silhouette value Si for the ith point is defined as

% Si = (bi-ai)/ max(ai,bi)
% where ai is the average distance from the ith point to the other points in the same cluster as i, 
% and bi is the minimum average distance from the ith point to points in a different cluster, minimized over clusters.

% The silhouette value ranges from –1 to 1. 
% A high silhouette value indicates that i is well matched to its own cluster, and poorly matched to other clusters. 
% If most points have a high silhouette value, then the clustering solution is appropriate. If many points have a low or negative silhouette value, then the clustering solution might have too many or too few clusters. You can use silhouette values as a clustering evaluation criterion with any distance metric.
rng(1) % for reproducibility
[idx,C] = kmeans(data,6);
figure(3)
silhouette(data,idx);
figure(2)
ex7a_0_show_clusters(data, idx, C);

% let see how good we are 
scatter(data(numspecies==1,1),data(numspecies==1,2),15,idx(numspecies==1),"^");
hold on
scatter(data(numspecies==2,1),data(numspecies==2,2),15,idx(numspecies==2),"o");
hold on
scatter(data(numspecies==3,1),data(numspecies==3,2),15,idx(numspecies==3),"+");
hold off
legend(unique(species), 'Location', 'southeast');

