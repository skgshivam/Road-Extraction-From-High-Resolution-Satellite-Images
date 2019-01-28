I1=imread('got.jpg');
I2=imread('ground.jpg');

I3=I1(:);
I4=I2(:);
I5=I3>254;
I6=I4>254;

%I3(
c=confusionmat(I5,I6);
disp('confusion');
disp(c);
d=c(:);
%d(2)
%d(3)
error=(d(2)+d(3))/(d(1)+d(2)+d(3)+d(4))*100
%error=c(0,1)+c(1,0);

%error=((c(:,[0,1])+c(:,[1,0]))/(c(:,[0,0])+c(:,[0,1])+c(:,[1,0])+c(:,[1,1])))*100;