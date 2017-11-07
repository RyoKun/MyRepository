classdef Frog
    %Frog �J�G���̌̂̃p�����[�^�┭��/�x�~��Ԃ̐؂�ւ��𐧌�
    properties
        flag = 1;           % ����/�x�~��������t���O�B 0:�x�~/1:����
        size                % �̒�
        energy              % �G�l���M�[�c��
        pActive = 1;        % �x�~��Ԃ��甭����Ԃւƈڍs����Ƃ��̊m��
        pSleep  = 1;        % ������Ԃ���x�~��Ԃւƈڍs����Ƃ��̊m��
        plotArray(1,100);   % �`�悷��_���i�[����z��
    end
    
    methods
        % �N���X�̃R���X�g���N�^
        % �����ŃC���X�^���X���i�[����z����쐬���A�f�[�^���Z�b�g����B
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
                
                % �x�~��Ԃ��甭����ԂւƑJ�ڂ���m���̌���
                
                
                % ������Ԃ���x�~��ԂւƑJ�ڂ���m���̌���
                I = Body(obj(k).size);
                J = relativeBodySize(obj, k, length(obj));
                obj(k).pSleep = I*J;
            end
        end
        
        % �����E�x�~��Ԃ̐؂�ւ��������ōs���B
        % ����StateCheck�֐���main�֐���1�b���ƂɌĂяo�����B
        function obj = StateCheck(obj, rand, t)
            for k = 1:length(obj)
                % ������Ԃ̏ꍇ�̐؂�ւ�
                if obj(k).flag == 1
                    if obj(k).pActive > rand
                        obj(k) = ModeActive(obj(k), t, k);
                    else 
                        obj(k).flag = 0;
                        obj(k) = ModeSleep(obj(k), t);
                    end
                % �x�~��Ԃ̏ꍇ�̐؂�ւ�
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
            
        % ������Ԃ̏���
        function obj = ModeActive(obj, time, num)
            if obj.flag == 1
                obj.energy = obj.energy - 1;
                obj.plotArray(1,time) = num;
                if obj.energy == 0    % �����G�l���M�[��0�ɂȂ�����
                    obj.flag = 0;     % �����I�ɋx�~��Ԃֈڍs
                end
            end
        end
        
        % �x�~��Ԃ̏���
        function obj = ModeSleep(obj, time)
            if obj.flag == 0
                obj.energy = obj.energy + 1;
                obj.plotArray(1,time) = -1; 
                if obj.energy == 30   % �����G�l���M�[������ɒB������
                    obj.flag = 1;     % �����I�ɔ�����Ԃֈڍs
                end
            end
        end
    end
end