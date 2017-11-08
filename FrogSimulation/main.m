x = linspace(0, 99, 100);
ylim([0 4]);

NUM = 3;                % ���̐�
size   = [35, 22, 35];  % �̒����i�[�����x�N�g��
energy = [30, 30, 30];  % �G�l���M�[���i�[�����x�N�g��

% �z��frog�ɃC���X�^���X���i�[����B
frog = Frog(NUM, size, energy);
fprintf('%d data are set.\n', length(frog));

for t = 1:length(x) % length(x)��100
   
    Rand = rand; % [0,1]�͈̔͂ŗ����𐶐�
    frog = ProbabilityUpdate(frog);    % �m����ݒ�
    frog = StateCheck(frog, Rand, t);  % ����/�x�~��Ԃ�ؑ�
    disp(frog(2).energy);
end

% �ȉ��A�`��ݒ�
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