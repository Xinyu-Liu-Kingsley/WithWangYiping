close all
clear
clc

dbstop if error
% load Distance.mat
load('distance_2.mat');

MAX_DISTANCE = 1;
% init
Num = length(distance);
Dist = zeros(Num,Num);
line = struct('distance',zeros(1,Num),'flag',zeros(1,1),'kind',zeros(1,1));
for i = 1 : Num
    line(i).distance = zeros(1,Num);
    line(i).flag = 0;
    line(i).kind = i;
end

% cell to matrix
% distance = cell2mat(distance);

for i=1:Num
    Dist(i,:) = distance{i}; 
end

% Sort the distance array
distNum = size(Dist,1);
for i = 1 : distNum-1
    [min_dist, min_dist_idx] =  findSecondMin(Dist(i,:),i);
    if(Dist(i,min_dist_idx) < MAX_DISTANCE)
        if line(i).flag == 0
            line(i).kind = min_dist_idx;
            line(min_dist_idx).flag = 1;
        end
    end
end

kind_array = zeros(distNum,1);
for i = 1 : distNum
    kind_array(i) = line(i).kind;
end
[cluster, ia , kind_idx] = unique(kind_array);





function [secondMin, idx] =findSecondMin(distance,min_idx)
    dist = distance;
    distNum = length(dist);
    for i = 1 : distNum-1
        for j = i+1 : distNum
            if(dist(i) > dist(j))
                tmp = dist(j);
                dist(j) = dist(i);
                dist(i) = tmp;
            end
        end
    end
    if (min_idx < distNum)
        secondMin = dist(min_idx+1);
    end
    idx = find(distance == secondMin);
end
