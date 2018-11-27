% Esta vista recibe como entrada 2 puntos entre los cuales estará el
% conjunto de datos
function inputLayout(file)
    % construir la vista
    hs = build(150,500);
    % mostrar la 'figura' de la vista
    hs.fig.Visible = 'on';
    % -------------------------subfunciones--------------------------------
    % "build":
    % agrega los componentes de GUIDE a la 'figura' de la vista y da como
    % resultado todos estos en una estructura de datos
    function hs = build(height, width)
        hs.fig = figure('Visible','off',...
                  'Resize','off',...
                  'Tag','fig',...
                  'Position',[200 200 width height]);
        
        % agregar cajas de texto
        hs.x1Txtbox = uicontrol(hs.fig,'Style','edit',...
                'String','x1',...
                'Position',[(width / 2 - 200) 100 200 20]);
        hs.y1Txtbox = uicontrol(hs.fig,'Style','edit',...
                'String','y1',...
                'Position',[(width / 2) 100 200 20]);
        hs.x2Txtbox = uicontrol(hs.fig,'Style','edit',...
                'String','x2',...
                'Position',[(width / 2 - 200) 50 200 20]);
        hs.y2Txtbox = uicontrol(hs.fig,'Style','edit',...
                'String','y2',...
                'Position',[(width / 2) 50 200 20]);
        % agregar botón de aceptar
        hs.submitButton = uicontrol(hs.fig,...
                  'String','Submit',...
                  'Tag','button',...
                  'Callback',@buttonCallback,...
                  'Position',[(width / 2 - 100) 10 200 30]);
    end
    % "buttonCallback":
    % esta función es llamada cada vez que el botón de la vista es
    % presionado
    function buttonCallback(hObject, event)
        % leer las cajas de texto
        x1 = floor(str2double(hs.x1Txtbox.String));
        y1 = floor(str2double(hs.y1Txtbox.String));
        x2 = floor(str2double(hs.x2Txtbox.String));
        y2 = floor(str2double(hs.y2Txtbox.String));
        
        h=length(file(:, 1));
        w=length(file(1, :));
        if x1 ~= x2 || y1 ~= y2
            % validar las entradas
            if x1 > 0 && x1 <= w && y1 > 0 && y1 <= h && ...
                x2 > 0 && x2 <= w && y2 > 0 && y2 <= h
                
                % asignar un valor de dirección y el punto inicial de los
                % datos
                angle = atan2(y2-y1,x2-x1);
                angle = angle*180/pi;
                if angle > 90
                    angle = angle-180;
                end
                if angle < -90
                    angle = angle+180;
                end
                
                % escoger el pixel de inicio
                x = min([x1 x2]);
                y = y1;
                if x2 == x
                    y = y2;
                end
                if x1 == x2
                    y = min([y1 y2]);
                    x = x1;
                    if y2 == y
                        x = x2;
                    end
                end
                
                % simplificar la dirección a una de las 4 direcciones
                dir=0;
                if angle <= 77.5
                    if angle >= 22.5
                        dir = 1;
                    elseif angle >= -22.5
                        dir = 2;
                    elseif angle >= -77.5
                        dir = 3;
                    end
                end
                
                % asignar el tamaño del grupo de datos
                len=max([(abs(x2 - x1) + 1) (abs(y2 - y1) + 1)]);
                if len>138
                    len=138;
                end
                
                close all
                % abrir la vista de visualización de datos
                dataLayout(file, [x y], len, dir);
            end
        end
    end
end