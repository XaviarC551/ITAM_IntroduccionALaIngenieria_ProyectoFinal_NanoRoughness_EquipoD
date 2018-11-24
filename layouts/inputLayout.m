function inputLayout(file)
   hs = build(150,500);
   hs.fig.Visible = 'on';
   function hs = build(height,width)
       hs.fig = figure('Visible','off',...
                  'Resize','off',...
                  'Tag','fig',...
                  'Position',[200 200 width height]);
       hs.txtbox = uicontrol(hs.fig,'Style','edit',...
                'String','x1',...
                'Position',[width/2-200 100 200 20]);
       hs.txtbox2 = uicontrol(hs.fig,'Style','edit',...
                'String','y1',...
                'Position',[width/2-200+200 100 200 20]);
       hs.txtbox3 = uicontrol(hs.fig,'Style','edit',...
                'String','x2',...
                'Position',[width/2-200 50 200 20]);
       hs.txtbox4 = uicontrol(hs.fig,'Style','edit',...
                'String','y2',...
                'Position',[width/2-200+200 50 200 20]);
       
       hs.btn = uicontrol(hs.fig,...
                  'String','Submit',...
                  'Tag','button',...
                  'Callback',@buttonCallback,...
                  'Position',[width/2-100 10 200 30]);
   end
   

   function buttonCallback(hObject,event)
        if(strcmp(hObject.Tag,'button'))
            x1=floor(str2double(hs.txtbox.String));
            y1=floor(str2double(hs.txtbox2.String));
            x2=floor(str2double(hs.txtbox3.String));
            y2=floor(str2double(hs.txtbox4.String));
            
            h=length(file(:,1));
            w=length(file(1,:));
            if x1~=x2 || y1~=y2
                if x1>0 && x1<=w && y1>0 && y1<=h &&...
                    x2>0 && x2<=w && y2>0 && y2<=h
                    angle=atan2(y2-y1,x2-x1);
                    angle=angle*180/pi;
                    if angle>90
                        angle=angle-180;
                    end
                    if angle<-90
                        angle=angle+180;
                    end
                    x=min([x1 x2]);
                    y=y1;
                    if x2==x
                        y=y2;
                    end
                    if x1==x2
                        y=min([y1 y2]);
                        x=x1;
                        if y2==y
                            x=x2;
                        end
                    end
                    dir=0;
                    if angle<=77.5
                        if angle>=22.5
                            dir=1;
                        elseif angle>=-22.5
                            dir=2;
                        elseif angle>=-77.5
                            dir=3;
                        end
                    end
                    close all
                    len=max([abs(x2-x1)+1 abs(y2-y2)+1]);
                    dataLayout(file,[x y],len,dir);
                end
            end
        end
   end
end