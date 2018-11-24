function fileLayout()
   hs = build(100,500);
   hs.fig.Visible = 'on';
   function hs = build(height,width)
       hs.fig = figure('Visible','off',...
                  'Resize','off',...
                  'Tag','fig',...
                  'Position',[200 200 width height]);
       hs.txtbox = uicontrol(hs.fig,'Style','edit',...
                'String','Enter the name of your file',...
                'Position',[width/2-100 50 200 20]);
       hs.btn = uicontrol(hs.fig,...
                  'String','Submit',...
                  'Tag','button',...
                  'Callback',@buttonCallback,...
                  'Position',[width/2-100 10 200 30]);
       hs.btn.Visible='on';
    end   

   function buttonCallback(hObject,event)
        if(strcmp(hObject.Tag,'button'))
            filename=hs.txtbox.String;
            if isfile("img/"+filename)
                close all
                img=imread(char("img/"+filename));
                img=img(:,:,1);
                mainLayout(1,img);
            end
        end
   end
end
