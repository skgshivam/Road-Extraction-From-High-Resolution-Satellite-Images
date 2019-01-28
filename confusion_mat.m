I1=imread('pak.jpg');
I2=imread('pak1.jpg');

I3=I1(:);
I4=I2(:);
I5=I3>254;
I6=I4>254;

%I3(
c=confusionmat(I5,I6);
disp('confusion');
disp(c);