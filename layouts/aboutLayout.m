% Esta vista muestra informaci�n sobre la aplicaci�n
function aboutLayout(status, file)
    % construir la ventana
    hs = build(500, 430);
    % mostrar la 'figura' de la ventana
    hs.fig.Visible = 'on';
    % -------------------------subfunciones--------------------------------
    % "build":
    % agrega los componentes de GUIDE a la 'figura' de la ventana y da como
    % resultado todos estos en una estructura de datos
    function hs = build(height, width)
        hs.fig = figure('Visible', 'off', ...
                  'Resize', 'off', ...
                  'Tag', 'fig', ...
                  'Position', [200 200 width height]);
        hs.label=uicontrol(hs.fig, 'Style', 'text', ...
                'FontSize', 12, ...
                'String', 'About', ...
                'FontWeight', 'bold', ...
                'Position', [0 height-50 width 50]);
        % agregar los nombres de los integrantes
        hs.label=uicontrol(hs.fig, 'Style', 'text', ...
                'FontSize', 10, ...
                'String', char("        Developed by Team D:                     Andr�s Quevedo                          Diego Maguey                             Javier Prieto                 Luis Hern�ndez"), ...
                'FontWeight', 'bold', ...
                'Position', [width/2-100 70 200 350]);
        % agregar el bot�n de regreso
        hs.backButton = uicontrol(hs.fig, ...
                  'String', 'Back', ...
                  'Tag', 'button2', ...
                  'Callback', @buttonCallback, ...
                  'Position', [width/2-100 10 200 30]);
    end
    % "buttonCallback":
    % esta funci�n es llamada cada vez que el bot�n de la ventana es
    % presionado
    function buttonCallback(hObject, event)
        close all
        % abrir la ventana principal
        mainLayout(status, file);
    end
end