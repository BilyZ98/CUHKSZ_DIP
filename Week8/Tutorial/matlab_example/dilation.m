clc
clear

A = imread('Fig0906(a).tif');
B = [0 1 0
     1 1 1
     0 1 0];
 A2 = imdilate(A, B);
 A3 = imdilate(A2, B); % ��������
 A4 = imdilate(A3, B); % ��������
%  A2 = imdilate(B,A); 
subplot(221)
imshow(A)
title('ԭʼͼ��')

subplot(222)
imshow(A2)
title('ʹ�ýṹԪ��[B]һ�����ͺ��ͼ��')

subplot(223)
imshow(A3)
title('ʹ�ýṹԪ��[B]�������ͺ��ͼ��')

subplot(224)
imshow(A4)
title('ʹ�ýṹԪ��[B]�������ͺ��ͼ��')

figure(2)
imshow(A2-A) % ��ʾ���ӵĲ���
title('ʹ�ýṹԪ��[B]һ�����ͺ��ԭͼ����Ƚ����ӵĲ���')
