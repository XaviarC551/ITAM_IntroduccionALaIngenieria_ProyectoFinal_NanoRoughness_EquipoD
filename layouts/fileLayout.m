% En esta vista, el usuario selecciona el archivo que se desea analizar
function fileLayout()
    % construir la ventana
    hs = build(100,500);
    % mostrar la 'figura' de la ventana
    hs.fig.Visible = 'on';
    % -------------------------subfunciones--------------------------------
    % "build":
    % agrega los componentes de GUIDE a la 'figura' de la ventana y da como
    % resultado todos estos en una estructura de datos
    function hs = build(height,width)
        hs.fig = figure('Visible','off',...
                  'Resize','off',...
                  'Tag','fig',...
                  'Position',[200 200 width height]);
        % agregar la caja de texto
        hs.fileNameTxtbox = uicontrol(hs.fig,'Style','edit',...
                'String','Enter the name of your file',...
                'Position',[width/2-100 50 200 20]);
        % agregar el botón de aceptar
        hs.btn = uicontrol(hs.fig,...
                  'String','Submit',...
                  'Tag','button',...
                  'Callback',@buttonCallback,...
                  'Position',[width/2-100 10 200 30]);
        hs.btn.Visible='on';
    end   
    % "buttonCallback":
    % esta función es llamada cada vez que el botón de la ventana es
    % presionado
    function buttonCallback(hObject,event)
        if(strcmp(hObject.Tag,'button'))
            filename = hs.fileNameTxtbox.String;
            if isfile("img/" + filename)
                close all
                % leer la imagen del MFA
                img = imread(char("img/"+filename));
                % usar solo el primer canal de la imagen
                img = img(:, :, 1);
                % abrir la vista principal
                mainLayout(1,img);
            end
        end
    end
end
