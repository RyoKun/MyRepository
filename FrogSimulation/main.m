x = linspace(0, 99, 100);
ylim([0 4]);

NUM = 3;                % 総個体数
size   = [35, 22, 35];  % 体長を格納したベクトル
energy = [30, 30, 30];  % エネルギーを格納したベクトル

% 配列frogにインスタンスを格納する。
frog = Frog(NUM, size, energy);
fprintf('%d data are set.\n', length(frog));

for t = 1:length(x) % length(x)は100
   
    Rand = rand; % [0,1]の範囲で乱数を生成
    frog = ProbabilityUpdate(frog);    % 確率を設定
    frog = StateCheck(frog, Rand, t);  % 発声/休止状態を切替
    disp(frog(2).energy);
end

% 以下、描画設定
%x = 1:100;
plot(x, frog(1).plotArray, 'r *'); 
hold on

plot(x, frog(2).plotArray, 'g *');
hold on

plot(x, frog(3).plotArray, 'b *');
hold on

axis([0, 100, 0, 4])
yticks([1 2 3])
yticklabels({'3','2','1'})
xlabel('Time', 'FontSize', 14, 'Color','k')
ylabel('Number', 'FontSize', 14, 'Color','k')