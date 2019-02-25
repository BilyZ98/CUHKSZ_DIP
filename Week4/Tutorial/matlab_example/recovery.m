% Ref: https://blog.csdn.net/u010592995/article/details/73555425
figure(1)
N = 15;     % ��������
f = 1;       % �ź�Ƶ��1Hz
Fs = 10;     % ����Ƶ�� 10Hz
Ts = 0.1;   % ������� 

T = N*Ts;    % ����ʱ��
n = 0:N-1;    % ʱ���������(N������)
NP = floor( (1/f)/(Ts) );    % 1�����ڲ�������
                             % Ϊ�������ʾ����,ֻ��1������                     
nTs = n*Ts;         % ʱ�����ʱ������
ts = 0:Ts:Ts*N;
x = sin(2*pi*f*ts);  %ʱ�����,
subplot(211);
stem(ts, x);
title(['sampled signal, Ts=' num2str(Ts)]);

% ������Ϊ�˸��õ���ʾ���������źŵĲ���
Ts1 = 0.001;                    
NP1 = floor( (1/f)/(Ts1) );
t1 = [0:T/Ts1-1]*Ts1;   
f1 = sin(2*pi*t1);
hold on;
plot(t1,f1,'r-');
hold off;

% ���濪ʼ���ڲ巨�ؽ��ź�
% �����ź�: x(n)=f
% �������: T=Ts
% ԭ��(�ڲ巨): y(t)=��x(n)sinc((t-nTs)/Ts)
t1 = 0;     % ��ʼʱ��
t2 = 1/f;   % ����ʱ��(ȡ�źŵ�1������)

interpfac = 10;
fs_sinc = interpfac * Fs;   % �ڲ庯���Ĳ����ʣ���Դ�źŹ������Ĳ����ʣ�Ĭ��10��������

Dt = Ts / interpfac;
t = t1:Dt:t2;

ta = t1:Dt:Ts*N;
fa = zeros(length(ta),1);

for t = 0:length(ta)-1              % ����������ÿ��ֵ
    for m = 0:length(nTs)-1         % �ۼ�sinc��ԭ������Ӧ��Ļ�
        fa(t+1) = fa(t+1) + x(m+1)*sinc((t*Dt - m*Ts)/Ts) ;
    end
end

subplot(212);
stem(ta, fa)
title('Function Reconstruction (Recovery) from Sampled Data');

