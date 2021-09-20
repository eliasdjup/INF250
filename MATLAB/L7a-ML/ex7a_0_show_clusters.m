function [] = ex7a_0_show_clusters(data, clusters, centroids)
    colormap lines; % to get nicer colors
    scatter(data(:,1),data(:,2),15,clusters);
    hold on;
    scatter(centroids(:,1),centroids(:,2),150,'+');
    hold off;
end

