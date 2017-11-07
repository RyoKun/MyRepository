function I = Body(size)
%Body カエルが体長が小さいほど休止しやすいことを考慮した関数
%   詳細説明をここに記述
I = exp(-5*(size - 22));
end

