%
%
% Morphological image procession:  1.) image read 
%
clf; clear all; 
%
iA = imread('stpicorig.jpg'); 
iA = permute(iA(end:-1:1,:,:),[2 1 3]); %% read an image
iG = rgb2gray(iA); %% convert to grayscale
is = size(iA); 
%
SEsi = 2; 
%
% plot...
subplot(1,2,1), imshow(iA); 
subplot(1,2,2), imshow(iG); 
%
%
%
% Morphological image procession:  2.) extract text
%
clf; 
%
% txt = iA(2540:2960,510:1750,:); 
% txt = iA(2540:3450,510:1750,:); 
txt = iA(2540:4000,510:1750,:); 
txtG = rgb2gray(txt);
%
% plot...
subplot(1,2,1), imshow(txt); 
subplot(1,2,2), imshow(txtG); 
%
%
%
% Morphological image procession: 3., threshold
%
clf; 
%
avPR = mean(txtG,2); % mean values per row
cl = polyfit(1:size(avPR,1),avPR.',1); % fit a line 
ml = polyval(cl,1:size(avPR,1)); % evaluate the line
%
txtGB = txtG < repmat(ml.'-8,1,size(txtG,2));
%
subplot(1,2,1), imshow(txtG); 
subplot(1,2,2), imshow(txtGB);
%
%
%
% Morphological image procession: 4., erode
%
clf; 
%
SE = strel('square',SEsi); % structural element 
%
txtGBer = imerode(txtGB,SE); 
%
subplot(1,2,1); imshow(txtGB); 
subplot(1,2,2); imshow(txtGBer); 
%
%
%
% Morphological image procession: 5., dilate
%
clf; 
%
SE = strel('square',SEsi); % structural element 
%
txtGBdi = imdilate(txtGB,SE); 
%
subplot(1,2,1); imshow(txtGB); 
subplot(1,2,2); imshow(txtGBdi); 
%
%
%
% Morphological image procession: 6., open
%
clf; 
%
SE = strel('square',SEsi); % structural element 
%
txtGBop = imopen(txtGB,SE); 
%
subplot(1,2,1); imshow(txtGB); 
subplot(1,2,2); imshow(txtGBop); 
%
%
%
% Morphological image procession: 7., close
%
clf; 
%
SE = strel('square',SEsi); % structural element 
%
txtGBcl = imclose(txtGB,SE); 
%
subplot(1,2,1); imshow(txtGB); 
subplot(1,2,2); imshow(txtGBcl); 
%
