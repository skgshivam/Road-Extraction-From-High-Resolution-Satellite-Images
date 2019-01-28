I = imread('gtruth5_2.jpg');
J=im2bw(I,0.65);
%whos
figure,imshow(J);
title('BINARY IMAGE ');