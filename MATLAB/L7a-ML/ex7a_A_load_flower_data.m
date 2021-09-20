clear;

% Iris flower data set.
% sepal length, sepal width, petal length, and petal width for 150 iris specimens
% https://en.wikipedia.org/wiki/Iris_flower_data_set
load fisheriris

% get sepal and petal data
sepals = meas(:,1:2);
petals = meas(:,3:4);

% converts species into numbers
numspecies = grp2idx(species);

% shows the data
[S,AX,BigAx,H,HAx]=plotmatrix(meas);
xlabel(AX(4,1),"Sepal Length");
xlabel(AX(4,2),"Sepal Width");
xlabel(AX(4,3),"Petal Length");
xlabel(AX(4,4),"Petal Width");
ylabel(AX(1,1),"Sepal Length");
ylabel(AX(2,1),"Sepal Width");
ylabel(AX(3,1),"Petal Length");
ylabel(AX(4,1),"Petal Width");
