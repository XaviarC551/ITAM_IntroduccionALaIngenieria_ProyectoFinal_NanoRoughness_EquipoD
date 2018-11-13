close all;
clear;clc;
AMF = imread('img/Imagen4AMFFinal.gif');

h=length(AMF(:,1));
w=length(AMF);

x = randi(length(AMF));
y = randi(length(AMF(:,1)));

%switch(randi(3))
%    case 1 
%        dirX = 0;
%        dirY = 1;
%    case 2
%        dirX = 1;
%        dirY = 0;
%    case 3
%        dirX = 1;
%        dirY = 1;
%end


%for k=2:6
%    dirX=mod(k+1,2)
%    dirY=mod(k,3)-1
%end

%d  |1   2   3   4   5
%   |------------------
%dY |1   -1  0   1   -1
%dX |1   0   1   0   1
d=randi(5);
% -1 | 0 | 1
dirY=mod(d+1,3)-1
% 0 | 1
dirX=mod(d,2)

datos=[];
fx=x;
fy=y;
for i=0:(randi(137))
    if ((x+dirX*i) > w || (y+dirY*i) > h || (y+dirY*i) < 1)
        break
    end  
    
    datos(i+1) = AMF(y+dirY*i,x+dirX*i);
    x=x+dirX*i;
    y=y+dirY*i;
end
xg = 1:length(datos);
yg = datos;
plot(xg,yg)
axis([1,length(datos)+1,0,255])
grid on

figure
imshow(AMF);

figure
imshow(AMF);
hold on
plot([x fx],[y fy],'r','LineWidth',2);
hold off