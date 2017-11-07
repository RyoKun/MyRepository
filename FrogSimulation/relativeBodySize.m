function J = relativeBodySize( obj, k, NUM )
%relativeBodySize 隣り合った個体との相対的な体長を考慮した関数。

    % 注目するカエルが1番目の場合の処理
    if k == 1
        if obj(1).size < obj(2).size
            J = abs(obj(1).size - obj(2).size)/17;
        else 
            J = 1;
        end 
    % 注目するカエルが最終番号の場合の処理
    elseif k == NUM
        if obj(NUM).size < obj(NUM - 1).size
            J = abs(obj(NUM).size - obj(NUM - 1).size)/17;
        else
            J = 1;
        end
    % 注目するカエルの両隣にカエルがいる場合の処理
    else
        % k-1 > k
        if obj(k).size < obj(k - 1).size
            if obj(k).size < obj(k + 1).size
                % 真ん中のカエル(k番目)が一番小さい場合 k-1 > k < k+1
                J = abs(obj(k).size - obj(k - 1).size) * abs(obj(k).size - obj(k + 1).size)/17;
            else
                % 前の番号のカエルだけが小さい場合 k-1 > k > k+1
                J = abs(obj(k).size - obj(k - 1).size)/17;
            end
        % k-1 < k
        else 
            % k-1 < k < k+1 
            if obj(k).size < obj(k + 1).size
                J = abs(obj(k).size - obj(k + 1).size)/17;
            % k-1 < k > k+1
            else
                J = 1;
            end
        end
    end
end