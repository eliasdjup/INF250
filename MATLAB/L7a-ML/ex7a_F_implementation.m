% define number of clusters
k = 3;
% define data
data = petals;

% random initialization - select random points from dataset
centroids = datasample(data,k)

% itnitialization using three first points
%centroids = [data(1,:); data(2,:); data(3,:)]

% itnitialization using three distinct ponits
%centroids = [data(1,:); data(3,:); data(4,:)]

% extract data size
n = size(data,1);

% init the idx vector and other variables
idx = zeros(n,1);
convergence = false;
iteration = 0;

while ~convergence
    iteration = iteration + 1;
    convergence = true; % assume this is the last iteration
    for dataID = 1:n
        % get data x and y
        xd = data(dataID,1);
        yd = data(dataID,2);
        
        maxDist = 999;
        centroid = -1;
        for clusterID = 1:k
            % get cluster x and y
            xc = centroids(clusterID,1);
            yc = centroids(clusterID,2);
            
            % compute distance
            dist = sqrt((xd-xc)^2 + (yd-yc)^2);
            
            % determine if the current centroid is the closest one
            if dist < maxDist
                maxDist = dist;
                centroid = clusterID;
            end
        end
        
        % check if something was changed
        if idx(dataID) ~= centroid
            convergence = false;
            idx(dataID) = centroid;
        end
    end
    
    %show the status before updating centroids
    ex7a_0_show_clusters(data,idx,centroids)
    
    % wait for user
    pause;
    
    % update centroids
    for clusterID = 1:k
        centroids(clusterID,:) = mean(data(idx==clusterID,:));
    end
    
    % show the updated centroids
    ex7a_0_show_clusters(data,idx,centroids)
end
