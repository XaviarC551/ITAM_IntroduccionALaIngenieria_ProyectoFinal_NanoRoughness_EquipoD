AMF = imread('Imagen4AMFFinal.gif');
x = randi(length(AMF));
y = randi(length(AMF(:,1)));

switch(randi(3))
    case 1 
        dirX = 0;
        dirY = 1;
    case 2
        dirX = 1;
        dirY = 0;
    case 3
        dirX = 1;
        dirY = 1;
end

for i=1:randi(138)
    if ((x+dirX*i) > length(AMF) || (y+dirY*i) > length(AMF(:,1))) 
        break
    end  
    
    datos(i) = AMF(y+dirY*i,x+dirX*i);
end

xg = 0:length(datos)-1;
yg = datos;
plot(xg,yg)
grid on

