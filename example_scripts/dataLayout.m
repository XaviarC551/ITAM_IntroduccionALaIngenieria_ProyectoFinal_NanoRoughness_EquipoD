%file,[1 1],138,3
function dataLayout(image,position,len,dir)
   data=[];
   active=[0,0,0,0,0,0,0,0];
   hs = build(500,1000);
   hs.fig.Visible = 'on';
   
   
   function hs = build(height,width)
       hs.fig = figure('Visible','off',...
                  'Resize','off',...
                  'Tag','fig',...
                  'Position',[200 200 width height]);
        hs.btn = uicontrol(hs.fig,...
                  'String','< Back',...
                  'Tag','button',...
                  'Callback',@buttonCallback,...
                  'Position',[width-width/2+200 height-height/2-80 100 20]);
        hs.ax = subplot(2,3,1);
        imshow(image)
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
       
       
       hs.ax2 = subplot(2,3,2);
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
        
       
       plotData()
       
        
        %disp(PromedioDePicosYValles(data,z))
        
        uicontrol(hs.fig,'Style','checkbox',...
                'Tag','check1',...
                'FontSize',10,...
                'String',char("Z="+num2str(mean(data))),...
                'Callback',@buttonCallback,...
                'Position',[width-width/2 height-height/2-20 150 20]);
        uicontrol(hs.fig,'Style','checkbox',...
                'Tag','check2',...
                'FontSize',10,...
                'String',char("Ra="+num2str(roughness(data))),...
                'Callback',@buttonCallback,...
                'Position',[width-width/2 height-height/2-40 150 20]);
        uicontrol(hs.fig,'Style','checkbox',...
                'Tag','check3',...
                'FontSize',10,...
                'String',char("Rq="+num2str(rootMeansSquare(data))),...
                'Callback',@buttonCallback,...
                'Position',[width-width/2 height-height/2-60 150 20]);
        [max,min]=maxPeakDepth(data);
        uicontrol(hs.fig,'Style','checkbox',...
                'Tag','check4',...
                'FontSize',10,...
                'String',char("Maximum="+num2str(max)),...
                'Callback',@buttonCallback,...
                'Position',[width-width/2 height-height/2-80 150 20]);
        uicontrol(hs.fig,'Style','checkbox',...
                'Tag','check5',...
                'FontSize',10,...
                'String',char("Minimum="+num2str(min)),...
                'Callback',@buttonCallback,...
                'Position',[width-width/2 height-height/2-100 150 20]);
        uicontrol(hs.fig,'Style','checkbox',...
                'Tag','check6',...
                'FontSize',10,...
                'String',char("Rt="+num2str(maxHeight(data))),...
                'Callback',@buttonCallback,...
                'Position',[width-width/2 height-height/2-120 150 20]);
        uicontrol(hs.fig,'Style','checkbox',...
                'Tag','check7',...
                'FontSize',10,...
                'String',char("Rz="+num2str(avrgProfile(data))),...
                'Callback',@buttonCallback,...
                'Position',[width-width/2 height-height/2-140 150 20]);
        uicontrol(hs.fig,'Style','text',...
                'FontSize',10,...
                'String',char("Rsk="+num2str(skewness(data))),...
                'Position',[width-width/2 height-height/2-160 150 20]);        
   end
%Imagen4AMFFinal.gif
    function plotData()   
        hs.ax3 = subplot(2,3,3);
        cla(hs.ax3,'reset')
        
        axis([1,length(data)+1,0,255]);
        grid on
        hold on
        plot(1:length(data),data,'b','Parent',hs.ax3);
        hold on
        if active(1)~=0
            z=mean(data);
            plot([1 length(data)],[z z],'r--','Parent',hs.ax3);
            hold on
        end
        if active(2)~=0
            ra=roughness(data);
            plot([1 length(data)],[ra ra],'k--','Parent',hs.ax3);
            hold on
        end
        if active(3)~=0
            rq=rootMeansSquare(data);
            plot([1 length(data)],[rq rq],'c--','Parent',hs.ax3);
            hold on
        end
        [max,min]=maxPeakDepth(data);
        if active(4)~=0
            plot([1 length(data)],[max max],'m--','Parent',hs.ax3);
            hold on
        end
        if active(5)~=0
            plot([1 length(data)],[min min],'g--','Parent',hs.ax3);
            hold on
        end
        if active(6)~=0
            height=maxHeight(data);
            plot([1 length(data)],[height height],'y--','Parent',hs.ax3);
            hold on
        end
        if active(6)~=0
            height=maxHeight(data);
            plot([1 length(data)],[height height],'k--','Parent',hs.ax3);
            hold on
        end
        if active(7)~=0
            [rz,peaks,peaksX,valleys,valleysX]=avrgProfile(data);
            plot(valleysX,valleys,'r.','Parent',hs.ax3);
            hold on
            plot(peaksX,peaks,'r.','Parent',hs.ax3);
            hold on
            plot([1 length(data)],[rz rz],'k--','Parent',hs.ax3);
            hold on
        end
        
        hold off
    end
   function buttonCallback(hObject,event)
        if(strcmp(hObject.Tag,'button'))
            close all
            mainLayout(1,image);
        else
            if(strcmp(hObject.Tag,'check1'))
                active(1)=hObject.Value;
            elseif(strcmp(hObject.Tag,'check2'))
                active(2)=hObject.Value;
            elseif(strcmp(hObject.Tag,'check3'))
                active(3)=hObject.Value;
            elseif(strcmp(hObject.Tag,'check4'))
                active(4)=hObject.Value;
            elseif(strcmp(hObject.Tag,'check5'))
                active(5)=hObject.Value;
            elseif(strcmp(hObject.Tag,'check6'))
                active(6)=hObject.Value;
            elseif(strcmp(hObject.Tag,'check7'))
                active(7)=hObject.Value;
            end
            plotData()
        end
   end
end
