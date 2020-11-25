close all
clear
clc
tic
dbstop if error
% load Distance.mat
% load('..\data\distance_2.mat');
load('distance_2.mat');

MAX_DISTANCE = 4;
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
Dist = Dist + Dist';
% Sort the distance array
distNum = size(Dist,1);

% newcount = 0;
for i = 1 : distNum-1
    kind_num = 1;
    newcount = 0;
    if line(i).flag == 0
%    new distance cols
        for j = 1 : distNum-1
            if line(j).flag == 0 
                newcount = newcount + 1;
                newdist_idx(newcount) = j;             
            end
        end
        
        newDist = zeros(1,length(newdist_idx));
        for m = 1:length(newdist_idx)
            newDist(m) = Dist(i,newdist_idx(m));
        end
        
        [idx] = findMin(newDist,MAX_DISTANCE);     
        for n =  1 : length(idx)
            line(idx(n)).flag = 1;
        end
        line(n).kind = kind_num;        
        line(n).flag = 1;
        kind_num = kind_num+1;
    end
end

kind_array = zeros(distNum,1);
for i = 1 : distNum
    kind_array(i) = line(i).kind;
end
[cluster, ia , kind_idx] = unique(kind_array);

kind_Nums = cell(1,length(cluster));
for i = 1 : length(cluster)
    clu = cluster(i);
    Num = find(kind_array == clu);
    kind_Nums{i} = Num';
end

%% 画图
% load line1.mat
% 
% for i = 1:length(cluster)
%     plot_line = kind_Nums{i};
%     for j = 1 : size(plot_line)
%         m = plot_line(j);
%         temp = line{m};
%         [~,tmpLine] = size(temp);
% %         x = line{m}(1,1:tmpLine);
% %         y = line{m}(2,1:tmpLine);
% %         z = line{m}(3,1:tmpLine);
%         x = line{m}(1,1);
%         y = line{m}(2,1);
%         z = line{m}(3,1);
%         if (i < 100)
%             plot3(x,y,z,'color',[i*0.01 0 0]);
%         elseif(100 <= i && i < 200)
%             plot3(x,y,z,'color',[(i-100)*0.01 (i-100)*0.01 0]);
%         elseif(200 <= i && i < 300)
%             plot3(x,y,z,'color',[(i-200)*0.01 (i-200)*0.01 (i-200)*0.01]);
%         elseif(300 <= i && i < 400)
%             plot3(x,y,z,'color',[(i-300)*0.01 0 (i-300)*0.01]);
%         elseif(400 <= i && i < 500)
%             plot3(x,y,z,'color',[(i-400)*0.01 0 (i-400)*0.01]);
%         elseif(500 <= i && i < 600)
%             plot3(x,y,z,'color',[0 0 (i-500)*0.01]);
%         elseif(600 <= i && i < 700)
%             plot3(x,y,z,'color',[0 (i-600)*0.01 0]);
%         elseif(700 <= i && i < 800)
%             plot3(x,y,z,'color',[0 (i-700)*0.01 0]);
%         elseif(800 <= i && i < 900)
%             plot3(x,y,z,'color',[(i-800)*0.01 (i-800)*0.01 (i-800)*0.01]);
%         elseif(900 <= i && i < 1000)
%             plot3(x,y,z,'color',[(i-900)*0.01 (i-900)*0.01 (i-900)*0.01]);
%         elseif(1000 <= i && i < 1100)
%             plot3(x,y,z,'color',[(i-1000)*0.01 (i-1000)*0.01 (i-1000)*0.01]);
%         elseif(1100 <= i && i < 1200)
%             plot3(x,y,z,'color',[(i-1100)*0.01 (i-1100)*0.01 (i-1100)*0.01]);
%         elseif(1200 <= i && i < 1300)
%             plot3(x,y,z,'color',[(i-1200)*0.01 (i-1200)*0.01 (i-1200)*0.01]);
%         elseif(1300 <= i && i < 1400)
%             plot3(x,y,z,'color',[(i-1300)*0.01 (i-1300)*0.01 (i-1300)*0.01]);
%         else
%             plot3(x,y,z,'color',[(i-1400)*0.01 (i-1400)*0.01 (i-1400)*0.01]);
%         end
%         hold on
%     end
% end

%% 打印输出类别信息
fprintf("总共有 %d 类:\n", length(cluster));
for i = 1 : distNum
    fprintf("第 %d 条曲线属于 第 %d 类\n",i, kind_idx(i));
end

toc
