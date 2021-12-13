clc; clear; close all;
load('./data/4patterns.mat');

%% Design of a Hopfield network
% Convert image matrix to vectors (binary: 0/1)
v1 = bwimg1(:);
v2 = bwimg2(:);
v3 = bwimg3(:);
v4 = bwimg4(:);

% Change to bipolar -1/1
vectors = [v1 v2 v3 v4] * 2 - 1;

% Train Hopfield network
net=newhop(vectors);
result=sim(net,4,[],vectors);

%% Test network
% Pick v4 as test data
vt = v4;
% Plot original image
figure,image(reshape(vt*100,[size(bwimg1,1),size(bwimg1,2)])),title('original image (memory)')
% vt*100 is used to increase the contrast 
% The original command can be: 
% figure,image(reshape(vt*100,[size(bwimg1,1),size(bwimg1,2)])),title('original image (memory)')

% Generate incomplete data by setting first 900 data missing
vt(1:900)=0;
% Plot damaged image
figure,image(reshape(vt*100,[size(bwimg1,1),size(bwimg1,2)])),title('damaged image (input)')
% Simulate the results using test data
test={vt};
epoch=20;
% Increase epoch number if the result is not good enough
result=sim(net,{1,epoch},{},test);

%% Plot recalled images
for i=1:epoch
    if mod(i,2) == 0 % plot recalled image every 2 iterations 
        figure,image(reshape(result{i}*100,[size(bwimg1,1),size(bwimg1,2)])) % rebuild image matrix
        title(['epoch' num2str(i)])
    end    
end