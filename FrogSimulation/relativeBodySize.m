function J = relativeBodySize( obj, k, NUM )
%relativeBodySize �ׂ荇�����̂Ƃ̑��ΓI�ȑ̒����l�������֐��B

    % ���ڂ���J�G����1�Ԗڂ̏ꍇ�̏���
    if k == 1
        if obj(1).size < obj(2).size
            J = abs(obj(1).size - obj(2).size)/17;
        else 
            J = 1;
        end 
    % ���ڂ���J�G�����ŏI�ԍ��̏ꍇ�̏���
    elseif k == NUM
        if obj(NUM).size < obj(NUM - 1).size
            J = abs(obj(NUM).size - obj(NUM - 1).size)/17;
        else
            J = 1;
        end
    % ���ڂ���J�G���̗��ׂɃJ�G��������ꍇ�̏���
    else
        % k-1 > k
        if obj(k).size < obj(k - 1).size
            if obj(k).size < obj(k + 1).size
                % �^�񒆂̃J�G��(k�Ԗ�)����ԏ������ꍇ k-1 > k < k+1
                J = abs(obj(k).size - obj(k - 1).size) * abs(obj(k).size - obj(k + 1).size)/17;
            else
                % �O�̔ԍ��̃J�G���������������ꍇ k-1 > k > k+1
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