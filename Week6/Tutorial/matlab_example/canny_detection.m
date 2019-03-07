clc
clear all
img_in=imread('./lena.jpg');
img_in=rgb2gray(img_in);
figure,imshow(img_in);
title('ԭͼ');

[rows,cols]=size(img_in);
thresh=graythresh(img_in);
img_bw=im2bw(img_in,thresh);%��ֵͼ��

%%%%step1:��˹�˲�
template=fspecial('gaussian',3,0.8);%����һ��3*3�ĸ�˹ģ�壬��׼��ѡ0.8
img_filt=imfilter(img_bw,template);

%%%%step2:�����ݶȣ����Ⱥͷ���
%Prewitt�ݶ�ģ��
%Ҳ��ѡ��һ�ײ�־��ģ�壺
%dx=[-1,-1;1,1] dy=[1,-1;1,-1]
%*********************
dx = [-1 -1 -1;0 0 0;1 1 1];%x������ݶ�ģ��
dy = [-1 0 1; -1 0 1;-1 0 1];%y������ݶ�ģ��
img_filt=double(img_filt);

grad_x=conv2(img_filt,dx,'same');%��ȡx������ݶ�ͼ��.ʹ���ݶ�ģ����ж�ά���,�����ԭͼ���С��ͬ
grad_y=conv2(img_filt,dy,'same');%��ȡy������ݶ�ͼ��.ʹ���ݶ�ģ����ж�ά���,�����ԭͼ���С��ͬ
grad=sqrt((grad_x.^2)+(grad_y.^2));%�ݶȷ�ֵͼ��

figure,imshow(grad);
title('�ݶȷ�ֵͼ');

grad_dir=atan2(grad_y,grad_x);%��ȡ�ݶȷ��򻡶�
grad_dir=grad_dir*180/pi;
%%%%step3:���ݶȷ�ֵ���зǼ���ֵ����
%���Ƚ��ǶȻ��ֳ��ĸ�����Χ:ˮƽ(0��)��-45�㡢��ֱ(90��)��+45��
for i = 1:rows
    for j = 1:cols
        if((grad_dir(i,j)>=-22.5 && grad_dir(i,j)<=22.5) || (grad_dir(i,j)>=157.5 && grad_dir(i,j)<=180)...
                                       ||(grad_dir(i,j)<=-157.5 && grad_dir(i,j)>=-180) )
            grad_dir(i,j) = 0;
        elseif((grad_dir(i,j) >= 22.5) && (grad_dir(i,j) < 67.5) || (grad_dir(i,j) <= -112.5) && (grad_dir(i,j) > -157.5))
            grad_dir(i,j) = -45;
        elseif((grad_dir(i,j) >= 67.5) && (grad_dir(i,j) < 112.5) || (grad_dir(i,j) <= -67.5) && (grad_dir(i,j) >- 112.5))
            grad_dir(i,j) = 90;
        elseif((grad_dir(i,j) >= 112.5) && (grad_dir(i,j) < 157.5) || (grad_dir(i,j) <= -22.5) && (grad_dir(i,j) > -67.5))
            grad_dir(i,j) = 45;  
        end
    end
end

%���۶�3x3������ĸ�������Ե������зǼ���ֵ����.��ȡ�Ǽ���ֵ����ͼ��
Nms = zeros(rows,cols);%����һ���Ǽ���ֵ����ͼ��
for i = 2:rows-1
    for j= 2:cols-1
        if (grad_dir(i,j) == 90 && grad(i,j) == max([grad(i,j), grad(i,j+1), grad(i,j-1)]))
            Nms(i,j) = grad(i,j);
        elseif (grad_dir(i,j) == -45 && grad(i,j) == max([grad(i,j), grad(i+1,j-1), grad(i-1,j+1)]))
            Nms(i,j) = grad(i,j);
        elseif (grad_dir(i,j) == 0 && grad(i,j) == max([grad(i,j), grad(i+1,j), grad(i-1,j)]))
            Nms(i,j) = grad(i,j);
        elseif (grad_dir(i,j) == 45 && grad(i,j) == max([grad(i,j), grad(i+1,j+1), grad(i-1,j-1)]))
            Nms(i,j) = grad(i,j);
        end
    end
end

figure,imshow(Nms);
title('�Ǽ���ֵ����ͼ');

%%%%step4:˫��ֵ�������ӱ�Ե
img_out=zeros(rows,cols);%����һ��˫��ֵͼ��
YH_L=0.1*max(max(Nms));%����ֵ
YH_H=0.3*max(max(Nms));%����ֵ
for i = 1:rows
    for j = 1:cols
        if(Nms(i,j)<YH_L)
           img_out(i,j)=0;
        elseif(Nms(i,j)>YH_H)
                img_out(i,j)=1;
        %��TL < Nms(i, j) < TH ʹ��8��ͨ����ȷ��
        
        elseif ( Nms(i+1,j) < YH_H || Nms(i-1,j) < YH_H || Nms(i,j+1) < YH_H || Nms(i,j-1) < YH_H ||...
                Nms(i-1,j-1) < YH_H || Nms(i-1, j+1) < YH_H || Nms(i+1, j+1) < YH_H || Nms(i+1, j-1) < YH_H)
                   img_out(i,j) = 1;   
        end  
    end
end
bw=edge(img_bw,'canny');

figure,imshow(img_out);
title('��ʵ����ͼ');

figure,imshow(bw);
title('������Canny����Ч��ͼ');
