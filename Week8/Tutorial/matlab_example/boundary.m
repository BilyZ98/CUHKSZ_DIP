clc
clear

figure(1)
BW = imread('Fig0914(a).tif');
imshow(BW)
title('ԭʼͼ��')

figure(2)
BW2 = bwmorph(BW,'remove'); % ��ʱ�ﲻ���������ȡ�߽�Ч��
subplot(221)
imshow(BW2)

BW3 = bwmorph(BW,'skel',Inf);
subplot(222)
imshow(BW3)

BW4 = bwmorph(BW,'shrink',Inf); % ȥ��ë�̵ġ���������
subplot(223)
imshow(BW4)

ginf = bwmorph(BW, 'thin', Inf); 
subplot(224)
imshow(ginf)
title('ʹ�ú���[bwmorph]ϸ�����ȶ�״̬���ͼ��')