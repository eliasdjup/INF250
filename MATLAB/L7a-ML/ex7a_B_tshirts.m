clear;

% generates random correlated data
rng(1); % for reproducibility
sigma = 5;
data = [];
for n = 1:50
    x = n + sigma*randn();
    y = n + sigma*randn();
    data = [data; [x,y]];
end

% shows the data
scatter(data(:,1), data(:,2), 15);
xlabel 'Height'; 
ylabel 'T-Shirt Size';

% use n means to define sizes
[idx,C] = kmeans(data,3);
ex7a_0_show_clusters(data, idx, C);
xlabel 'Height'; 
ylabel 'T-Shirt Size';
