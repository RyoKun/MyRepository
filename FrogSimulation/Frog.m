classdef Frog
    %Frog カエルの個体のパラメータや発声/休止状態の切り替えを制御
    properties
        flag = 1;           % 発声/休止条件判定フラグ。 0:休止/1:発声
        size                % 体長
        energy              % エネルギー残量
        pActive = 1;        % 休止状態から発声状態へと移行するときの確率
        pSleep  = 1;        % 発声状態から休止状態へと移行するときの確率
        plotArray(1,100);   % 描画する点を格納する配列
    end
    
    methods
        % クラスのコンストラクタ
        % ここでインスタンスを格納する配列を作成し、データをセットする。
        function obj = Frog(NUM, size, energy)
            if nargin ~= 0
                obj(NUM, 1) = Frog;
                for k = 1:length(obj)
                    obj(k).size = size(k);
                    obj(k).energy = energy(k);
                end
            end
        end
        
        function obj = ProbabilityUpdate(obj)
            for k = 1:length(obj)
                obj(k).pActive = 1;
                obj(k).pSleep  = 1;
                
                % 休止状態から発声状態へと遷移する確率の決定
                
                
                % 発声状態から休止状態へと遷移する確率の決定
                I = Body(obj(k).size);
                J = relativeBodySize(obj, k, length(obj));
                obj(k).pSleep = I*J;
            end
        end
        
        % 発声・休止状態の切り替えをここで行う。
        % このStateCheck関数はmain関数で1秒ごとに呼び出される。
        function obj = StateCheck(obj, rand, t)
            for k = 1:length(obj)
                % 発声状態の場合の切り替え
                if obj(k).flag == 1
                    if obj(k).pActive > rand
                        obj(k) = ModeActive(obj(k), t, k);
                    else 
                        obj(k).flag = 0;
                        obj(k) = ModeSleep(obj(k), t);
                    end
                % 休止状態の場合の切り替え
                else 
                    if obj(k).pSleep > rand
                        obj(k) = ModeSleep(obj(k), t);
                    else
                        obj(k).flag = 1;
                        obj(k) = ModeActive(obj(k), t, k);
                    end
                end
            end
        end
            
        % 発声状態の処理
        function obj = ModeActive(obj, time, num)
            if obj.flag == 1
                obj.energy = obj.energy - 1;
                obj.plotArray(1,time) = num;
                if obj.energy == 0    % もしエネルギーが0になったら
                    obj.flag = 0;     % 自動的に休止状態へ移行
                end
            end
        end
        
        % 休止状態の処理
        function obj = ModeSleep(obj, time)
            if obj.flag == 0
                obj.energy = obj.energy + 1;
                obj.plotArray(1,time) = -1; 
                if obj.energy == 30   % もしエネルギーが上限に達したら
                    obj.flag = 1;     % 自動的に発声状態へ移行
                end
            end
        end
    end
end