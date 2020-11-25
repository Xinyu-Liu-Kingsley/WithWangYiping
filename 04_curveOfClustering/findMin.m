function [idx] =findMin(distance,MAX_DISTANCE)
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
    count = 0;
    for ii = 1 : distNum-1
        if(dist(ii) < MAX_DISTANCE) && (dist(ii) ~= 0)
           tmpIdx = find(distance == dist(ii));
           count = count + 1;
           idx(1,count) = tmpIdx(1,1);
        end
    end
end