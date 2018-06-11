%
%   TOPIC: Mean Shift Clustering
%
% ------------------------------------------------------------------------

close all
clear clc
clearvars

%% Load data.

I = imread('peppers.png');
I = imresize(I, 0.25);

%% Perform mean shift clustering.

[fimg, labels, modes] = edison_wrapper(I, @RGB2Luv);  % FIXME: implement

%% Visualize results.

I_segm = Luv2RGB(fimg);

BW_boundaries = boundarymask(labels);
BW_boundaries = bwmorph(BW_boundaries, 'thin',Inf);

for i=1:2:20
    for j=5:5:20
        for k=150:1:150
            [fimg, labels, modes] = edison_wrapper(I, @RGB2Luv, 'SpatialBandwidth',i,'RangeBandWidth',j,'MinimumRegionArea',k);
            I_segm = Luv2RGB(fimg);

            BW_boundaries = boundarymask(labels);
            BW_boundaries = bwmorph(BW_boundaries, 'thin',Inf);
            figure(1); clf(1)
            subplot(1,3,1); imshow(I); title('original image');
            subplot(1,3,2); imshow(I_segm, []); title('clustered image');
            subplot(1,3,3); imshow(imoverlay(I, BW_boundaries, 'g')); title('cluster boundaries')
            title({['SpatialBandwidth ',num2str(i)];['RangeBandWidth ',num2str(j)];['MinimumRegionArea ',num2str(k)]})
            pause(1);
        end
    end
end

