clc
clear

A = imread('Fig0908(a).tif');
se = strel('disk', 10);

subplot(221)
imshow(A)
title('ԭʼͼ��')

A2 = imerode(A, se);
subplot(222)
imshow(A2)
title('ʹ�ýṹԪ��[disk��10��]��ʴ���ͼ��')

se = strel('disk', 5);
A3 = imerode(A, se);
subplot(223)
imshow(A3)
title('ʹ�ýṹԪ��[disk��5��]��ʴ���ͼ��')

A4 = imerode(A, strel('disk', 20));
subplot(224)
imshow(A4)
title('ʹ�ýṹԪ��[disk��20��]��ʴ���ͼ��')