classdef Frog
    %Frog カエルの個体のパラメータや発声/休止状態の切り替えを制御
    properties
        flag = 0;             % 発声/休止条件判定フラグ　 0:休止/1:発声
        energyZeroflag = 0;   % エネルギーが0になった時に1になるフラグ
        MAXenergy = 30;       % エネルギーの最大値
        size                  % 体長
        energy                % エネルギー残量
        pActive = 1;          % 休止状態から発声状態へと移行するときの確率
        pSleep  = 1;          % 発声状態から休止状態へと移行するときの確率
        plotArray(1,100);     % 描画する点を格納する配列
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
                    if obj(k).energyZeroflag == 1 
                        obj(k) = ModeSleep(obj(k), t);  
                    else
                        if obj(k).pActive > rand
                            obj(k) = ModeActive(obj(k), t, k);
                        else 
                            obj(k).flag = 0;
                            obj(k) = ModeSleep(obj(k), t);
                        end
                    end
                    
                % 休止状態の場合の切り替え
                else 
                    if obj(k).energy == obj(k).MAXenergy    % もしエネルギーがMAXなら
                        obj(k) = ModeActive(obj(k), t, k);  % 自動的にActiveへ遷移
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
        end
            
        % 発声状態の処理
        function obj = ModeActive(obj, time, num)
            obj.energy = obj.energy - 1;
            obj.plotArray(1,time) = num;
            % もしエネルギーが0になったらzeroフラグを立てる
            if obj.energy == 0
                obj.energyZeroflag = 1;
            end
        end
        
        % 休止状態の処理
        function obj = ModeSleep(obj, time)
            obj.energy = obj.energy + 1;
            obj.plotArray(1,time) = -1;
            % エネルギーが0になったことによりSleepに遷移した場合の処理
            if obj.energyZeroflag == 1
                if obj.energy == obj.MAXenergy
                    obj.energyZeroflag = 0;
                end
            end
        end
    end
end