clc
clear all;
close all;

%%%%%%%%%%%%%READING IMAGE%%%%%%%%%%%%%%%%%%

[file,path] = uigetfile;

I=imread(file);

%%%%%%%%%%%SHOWING ORIGINAL IMAGE%%%%%%%%%%%

figure;
imshow(I);
title('ORGINAL IMAGE');
%set(I,'PaperPositionMode','auto');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

J=rgb2gray(I);
%whos
figure,imshow(J);
title('GRAYSCALED IMAGE ');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


K=imadjust(J,[0.5 0.9],[]); 

figure;
imshow(K);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
level = graythresh(K);  
I=im2bw(K,level);  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I=imread(file);
I = im2bw(I, 0.65);
figure;
imshow(I);
title('BINARY IMAGE AFTER THRESHOLDING');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
B = medfilt2(I);
figure,imshow(B);
title('MEDIAN FILTERED IMAGE');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
im = bwareaopen(B,10000);   
%im2 = bwmorph(im, 'fill');
im3 = bwmorph(im, 'majority');
im=im3;
%se = ones(2,3);
se=strel('square',2);
im1=imclose(im,se);
%Binary = imfill(im,'holes');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,imshow(im1);

%hgexport(gcf, 'figure1.jpg', hgexport('factorystyle'), 'Format', 'jpeg') 
%title('removing connected components(pixel <6)');
%%%%%%%%%%%%%%%%%%CLOSING%%%%%%%%%%%%%
%se = strel('disk',10);
%closeBW=imclose(im,se);
%figure,imshow(closeBW);
%title('CLOSED IMAGE');
%im=closeBW;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BW = bwmorph(im,'remove');
figure,imshow(BW);
title('MORPHOLOGICAL FILTERED IMAGE');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BW1 = edge(BW,'sobel');
figure,imshow(BW1);
title('SOBEL EDGE DETECTION ON IMAGE');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BW2 = edge(BW,'canny',[0.36 0.9]);
%figure,imshow(BW2);
%title('edge detection(canny)');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
se = ones(2,3);
closeBW=imclose(BW1,se);
subplot(1,2,1), imshow(closeBW), title('CLOSED IMAGE');
subplot(1,2,2), imshow(im1), title('NORMAL');
%title('CLOSED IMAGE');
%imshow(im);

BW1=closeBW;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BWdfill = imfill(BW1,'holes');
%figure, imshow(BWdfill);
%title('binary image with filled holes');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BW1=BWdfill;

%%%%%%%% OVERALYING OBTAINED ROADS OVER GRAYSACLE IMAGE %%%%%%%
H = vision.AlphaBlender;
J = im2single(J);
BW1 = im2single(BW1);
Y = step(H,J,BW1);
figure,imshow(Y)
%title('overlay on grayscale image');


%whos

