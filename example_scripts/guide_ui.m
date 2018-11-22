function guide_ui
   hs = build;
   hs.fig.Visible = 'on';
   
   function hs = build
       hs.fig = figure('Visible','off',...
                  'Resize','off',...
                  'Tag','fig');
       
       hs.btn = uicontrol(hs.fig,'Position',[10 340 70 30],...
                  'String','Plot Sine',...
                  'Tag','button',...
                  'Callback',@plotsine);
       hs.ax = axes('Parent',hs.fig,...
                 'Position',[0.20 0.13 0.71 0.75],...
                 'Tag','ax');
   end

   function plotsine(hObject,event)
       theta = 0:pi/64:6*pi;
       y = sin(theta);
       plot(hs.ax,theta,y);
       guide_ui()
   end
end