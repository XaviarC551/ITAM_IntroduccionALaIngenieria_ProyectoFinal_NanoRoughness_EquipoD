%file,[1 1],138,3
function dataLayout(image,position,len,dir)
   hs = build(500,1000);
   hs.fig.Visible = 'on';
   function hs = build(height,width)
       hs.fig = figure('Visible','off',...
                  'Resize','off',...
                  'Tag','fig',...
                  'Position',[200 200 width height]);
        hs.btn = uicontrol(hs.fig,...
                  'String','Back',...
                  'Tag','button',...
                  'Callback',@buttonCallback,...
                  'Position',[width-width/2+200 height-height/2-80 100 20]);
        hs.ax = subplot(2,2,1);
        imshow(image)
        data=[];
        x=position(1);
        y=position(2);
        w=length(image(1,:));
        h=length(image(:,1));
        if dir==0
            dirX=0;
            dirY=1;
        elseif dir==1
            dirX=1;
            dirY=1;
        elseif dir==2
            dirX=1;
            dirY=0;
        elseif dir==3
            dirX=1;
            dirY=-1;
        end
       
       
       hs.ax2 = subplot(2,2,2);
       imshow(image)
       hold on
       plot([position(1) position(1)+dirX*len], [position(2) position(2)+dirY*len],...
           'r','LineWidth',3,'Parent',hs.ax2)
       hold off
        
        
        for i=0:len-1
            if ((x+dirX*i) > w || (y+dirY*i) > h || (y+dirY*i) < 1)
                break
            end  
            data(i+1) = image(y+dirY*i,x+dirX*i);
            fx=x+dirX*i;
            fy=y+dirY*i;
        end
        hs.ax3 = subplot(2,2,3);
        axis([1,length(data)+1,0,255]);
        grid on
        hold on
        plot(1:length(data),data,'Parent',hs.ax3);
        hold on
        [rz,peaks,peaksX,valleys,valleysX]=avrgProfile(data);
        plot(valleysX,valleys,'r.','Parent',hs.ax3);
        hold on
        plot(peaksX,peaks,'k.','Parent',hs.ax3);
        hold on
        z=mean(data);
        plot([1 length(data)],[z z],'r','Parent',hs.ax3);
        hold off
        %disp(PromedioDePicosYValles(data,z))
        
        uicontrol(hs.fig,'Style','text',...
                'FontSize',10,...
                'String',char("Z="+num2str(mean(data))),...
                'Position',[width-width/2 height-height/2-20 100 20]);
        uicontrol(hs.fig,'Style','text',...
                'FontSize',10,...
                'String',char("Ra="+num2str(roughness(data))),...
                'Position',[width-width/2 height-height/2-40 100 20]);
        uicontrol(hs.fig,'Style','text',...
                'FontSize',10,...
                'String',char("Rq="+num2str(rootMeansSquare(data))),...
                'Position',[width-width/2 height-height/2-60 100 20]);
        [max,min]=maxPeakDepth(data);
        uicontrol(hs.fig,'Style','text',...
                'FontSize',10,...
                'String',char("Maximum="+num2str(max)),...
                'Position',[width-width/2 height-height/2-80 100 20]);
        uicontrol(hs.fig,'Style','text',...
                'FontSize',10,...
                'String',char("Minimum="+num2str(min)),...
                'Position',[width-width/2 height-height/2-100 100 20]);
        uicontrol(hs.fig,'Style','text',...
                'FontSize',10,...
                'String',char("Rt="+num2str(maxHeight(data))),...
                'Position',[width-width/2 height-height/2-120 100 20]);
        uicontrol(hs.fig,'Style','text',...
                'FontSize',10,...
                'String',char("Rz="+num2str(avrgProfile(data))),...
                'Position',[width-width/2 height-height/2-140 100 20]);
        uicontrol(hs.fig,'Style','text',...
                'FontSize',10,...
                'String',char("Rsk="+num2str(skewness(data))),...
                'Position',[width-width/2 height-height/2-160 100 20]);        
   end
%Imagen4AMFFinal.gif

   function buttonCallback(hObject,event)
        if(strcmp(hObject.Tag,'button'))
            close all
            mainLayout(1,image);
        end
   end
end
