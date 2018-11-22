clear;clc;close all
msgs=["Developed by:"+newline+"..."+newline+"..."+newline+"..."
    "Greetings!"
    "Welcome to Team D's 'Nano Roughness' program"];
for i=1:length(msgs)
    disp(msgs(i))
    pause(2)
    clc
end
clc

ended=false;
loaded=false;

while ~ended
    clc
    m="What would you like to do? (-1: quit; 0:load a different file;"+newline+"1: generate a random data set; 2: input data set)";
    if ~loaded
        m="What would you like to do? (-1: quit; 0:load file)";
    end
    disp(m)
    a=floor(input(''));
    if ~loaded && a>0
        a=-2;
    end
    clc
    switch a
        case -1
            ended=true;
        case 0
            disp("Please enter the name of the file:")
            file=input('','s');
            if isfile("img/"+file)
                AMF = imread(char("img/"+file));
                loaded=true;
                h=length(AMF(:,1));
                w=length(AMF);
            else
                clc
                disp("The file you entered does not exist.")
                pause(1)
            end
        case 1
            close all;
            
            figure('Name','Original Image')
            imshow(AMF)
            
            x = randi(length(AMF));
            y = randi(length(AMF(:,1)));

            d=randi(5);
            dirY=mod(d+1,3)-1;
            dirX=mod(d,2);

            data=[];
            fx=x;
            fy=y;
            for i=0:(randi(137))
                if ((x+dirX*i) > w || (y+dirY*i) > h || (y+dirY*i) < 1)
                    break
                end  

                data(i+1) = AMF(y+dirY*i,x+dirX*i);
                fx=x+dirX*i;
                fy=y+dirY*i;
            end
            
            figure('Name','Image Cut')
            imshow(AMF);
            hold on
            plot([x fx],[y fy],'r','LineWidth',2);
            hold off
            
            xg = 1:length(data);
            yg = data;
            
            figure('Name','Data Set')
            plot(xg,yg,'b')
            axis([1,length(data)+1,0,255])
            hold on
            z=mean(data)
            plot([1, length(data)],[z, z],'r')
            grid on
            showFunctions(data)
        case 2
            close all;
            figure('Name','Original Image')
            imshow(AMF)
            [xI,yI]=ginput(2)
            imshow(AMF)
            
            l=(xI(1)-xI(2))^2+(yI(1)-yI(2))^2;
            l=floor(sqrt(l));
            if l<2
                l=2;
            end
            
            
            angle=atan2(yI(1)-yI(2),xI(1)-xI(2));
            angle=angle*180/pi;
            if angle>90
                angle=angle-180;
            end
            if angle<-90
                angle=angle+180;
            end
            dirX=0;
            dirY=-1;
            if angle>67.5
                dirX=0;
                dirY=1;
            elseif angle>22.5
                dirX=1;
                dirY=1;
            elseif angle>-22.5
                dirX=1;
                dirY=0;
            elseif angle>-67.5
                dirX=1;
                dirY=-1;
            end
            
            data=[]
            x=floor(min(xI))
            y=floor(yI(1))
            if(xI(2)==x)
                y=floor(yI(2))
            end
            fx=floor(x);
            fy=floor(y);
            for i=0:l-1
                if ((x+dirX*i) > w || (y+dirY*i) > h || (y+dirY*i) < 1)
                    break
                end  
                data(i+1) = AMF(y+dirY*i,x+dirX*i);
                fx=x+dirX*i;
                fy=y+dirY*i;
            end
            figure('Name','Image Cut')
            imshow(AMF);
            hold on
            plot([x fx],[y fy],'r','LineWidth',2);
            hold off
            
            xg = 1:length(data);
            yg = data;
            
            figure('Name','Data Set')
            plot(xg,yg,'b')
            axis([1,length(data)+1,0,255])
            hold on
            z=mean(data)
            plot([1, length(data)],[z, z],'r')
            grid on
            showFunctions(data)
            
        end
end
clear;clc;close all