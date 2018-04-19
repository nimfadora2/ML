%
%   TOPIC: K-Means Clustering
%
% ------------------------------------------------------------------------

close all
clear clc
clearvars

%% Load data.

I = imread('hestain.png');

figure(1);
imshow(I), title('H&E image (original)');

%% Perform k-means clustering.
p=3;
siz = size(I);
n = siz(1)*siz(2);
X = reshape(I,[n,p]);
X = double(X);
XX=kmeans(X,3, 'Distance','sqeuclidean', 'Replicates',3);

%% Show (image) labeling.

figure(2); clf(2)
pixel_labels = reshape(XX,[siz(1),siz(2)]); % FIXME: implement
imshow(pixel_labels, []), title('image labeled by cluster index');

%% Show data in each cluster.

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);
nColors=3;
for k = 1:nColors
    color = I;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end

figure(3); clf(3)
subplot(2,2,1); imshow(I); title('original image')
subplot(2,2,2); imshow(segmented_images{1}); title('objects in cluster 1');
subplot(2,2,3); imshow(segmented_images{2}); title('objects in cluster 2');
subplot(2,2,4); imshow(segmented_images{3}); title('objects in cluster 3');

%% Show clustering in RGB color space.


figure(4); clf(4)
colors = 'rgb';
markers = '...';
for idx = 1:3
    plot3(X(XX==idx,1),X(XX==idx,2),X(XX==idx,3))
    hold on;
end
hold off
title('K-means clustering')
xlabel('R'); ylabel('G'); zlabel('B')
grid
