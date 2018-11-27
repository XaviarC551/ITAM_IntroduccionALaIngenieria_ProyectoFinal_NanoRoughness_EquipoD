% Esta vista muestra los datos proporcionados y las funciones de rugosidad
function dataLayout(image, position, len, dir)
    data = [];
    % lista de funciones de rugosidad a mostrarse
    active = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    hs  =  build(500, 1000);
    % mostrar la 'figura' de la ventana
    hs.fig.Visible = 'on';
    % -------------------------subfunciones--------------------------------
    % "build":
    % agrega los componentes de GUIDE a la 'figura' de la ventana y da como
    % resultado todos estos en una estructura de datos
    function hs  =  build(height, width)
       hs.fig  =  figure('Visible', 'off', ...
                  'Resize', 'off', ...
                  'Tag', 'fig', ...
                  'Position', [200 200 width height]);
       hs.backButton = uicontrol(hs.fig, ...
                  'String', '< Back', ...
                  'Tag', 'button', ...
                  'Callback', @buttonCallback, ...
                  'Position', [(width - width / 2 + 200)...
                  (height - height /2 - 80) 100 20]);
       
       
       
       %----------------graficar y leer el conjunto de datos---------------
       % mostrar la imagen original
       hs.ax = subplot(2, 3, 1);
       imshow(image)
       
       x = position(1);
       y = position(2);
       w = length(image(1, :));
       h = length(image(:, 1));
       
       % separar la dirección de recorrido en componentes 'x' y 'y'
       switch dir
           case 0
                dirX = 0;
                dirY = 1;
           case 1
                dirX = 1;
                dirY = 1;
           case 2
                dirX = 1;
                dirY = 0;
           case 3
                dirX = 1;
                dirY = -1;
       end
       
       % mostrar la imagen, marcando los pixeles en el conjunto de datos
       hs.ax2  =  subplot(2, 3, 2);
       imshow(image)
       hold on
       plot([position(1) (position(1) + dirX * (len - 1))], ...
           [position(2) (position(2) + dirY * (len - 1))], ...
           'r', 'LineWidth', 3, 'Parent', hs.ax2)
       hold off
       
       % recorrer la imagen y guardar los valores en la lista de datos
       for i = 0:len-1
            if (x + dirX * i) > w || (y + dirY * i) > h ||... 
                    (y + dirY * i) < 1
                break
            end  
            data(i+1) = image(y + dirY * i, x + dirX * i);
       end
       
       % graficar el conjunto de datos
       plotData()
       
       %----agregar las casillas para mostrar las funciones de rugosidad---
       hs.check1 = uicontrol(hs.fig, 'Style', 'checkbox', ...
                'Tag', 'check1', ...
                'FontSize', 10, ...
                'String', char("Z = " + num2str(mean(data))), ...
                'Callback', @buttonCallback, ...
                'Position', [(width - width / 2) ...
                (height - height / 2 - 20) 150 20]);
       hs.check2 = uicontrol(hs.fig, 'Style', 'checkbox', ...
                'Tag', 'check2', ...
                'FontSize', 10, ...
                'String', char("Ra = " + num2str(roughness(data))), ...
                'Callback', @buttonCallback, ...
                'Position', [(width - width / 2)... 
                (height - height / 2 - 40) 150 20]);
       hs.check3 = uicontrol(hs.fig, 'Style', 'checkbox', ...
                'Tag', 'check3', ...
                'FontSize', 10, ...
                'String', ...
                char("Rq = " + num2str(rootMeansSquare(data))), ...
                'Callback', @buttonCallback, ...
                'Position', [(width - width / 2)... 
                (height - height / 2 - 60) 150 20]);
        [max, min] = maxPeakDepth(data);
       hs.check4 = uicontrol(hs.fig, 'Style', 'checkbox', ...
                'Tag', 'check4', ...
                'FontSize', 10, ...
                'String', char("Maximum = " + num2str(max)), ...
                'Callback', @buttonCallback, ...
                'Position', [(width - width / 2)... 
                (height - height / 2 - 80) 150 20]);
       hs.check5 = uicontrol(hs.fig, 'Style', 'checkbox', ...
                'Tag', 'check5', ...
                'FontSize', 10, ...
                'String', char("Minimum = " + num2str(min)), ...
                'Callback', @buttonCallback, ...
                'Position', [(width - width / 2)... 
                (height - height / 2 - 100) 150 20]);
       hs.check6 = uicontrol(hs.fig, 'Style', 'checkbox', ...
                'Tag', 'check6', ...
                'FontSize', 10, ...
                'String', char("Rt = " + num2str(maxHeight(data))), ...
                'Callback', @buttonCallback, ...
                'Position', [(width - width / 2)... 
                (height - height / 2 - 120) 150 20]);
       hs.check7 = uicontrol(hs.fig, 'Style', 'checkbox', ...
                'Tag', 'check7', ...
                'FontSize', 10, ...
                'String', char("Rz = " + num2str(avrgProfile(data))), ...
                'Callback', @buttonCallback, ...
                'Position', [(width - width / 2)... 
                (height - height / 2 - 140) 150 20]);
       hs.check8 = uicontrol(hs.fig, 'Style', 'checkbox', ...
                'Tag', 'check8', ...
                'FontSize', 10, ...
                'String', char("Rsk = " + num2str(skewness(data))), ...
                'Callback', @buttonCallback, ...
                'Position', [(width - width / 2)... 
                (height - height / 2 - 160) 150 20]);
    end
    % "plotData":
    % muestra el conjunto de datos en una gráfica y las funciones de
    % rugosidad seleccionadas
    function plotData()
        % borrar la gráfica de datos anterior
        hs.ax3  =  subplot(2, 3, 3);
        cla(hs.ax3, 'reset')
        
        axis([1, length(data) + 1, 0, 255]);
        grid on
        hold on
        plot(1:length(data), data, 'b', 'Parent', hs.ax3);
        hold on
        
        % borrar la gráfica de funciones de rugosidad anterior
        hs.ax4  =  subplot(2, 3, 4);
        cla(hs.ax4, 'reset')
        
        imagesc([-255, 255], [-255, 255],image,'Parent', hs.ax4)
        grid on
        hold on
        colormap(gray)
        hold on
        
        %------------condiciones para graficar de cada función-------------
        if active(1) ~= 0
            z = mean(data);
            plot([1 length(data)], [z z], 'r--', 'Parent', hs.ax3);
            hold on
            plot([-255 255], [z z], 'r', 'Parent', hs.ax4);
            hold on
        end
        if active(2) ~= 0
            ra = roughness(data);
            plot([1 length(data)], [ra ra], 'k--', 'Parent', hs.ax3);
            hold on
            plot([-255 255], [ra ra], 'b', 'Parent', hs.ax4);
            hold on
        end
        if active(3) ~= 0
            rq = rootMeansSquare(data);
            plot([-255 255], [rq rq], 'c--', 'Parent', hs.ax3);
            hold on
            plot([-255 255], [rq rq], 'c', 'Parent', hs.ax4);
            hold on
        end
        [max, min] = maxPeakDepth(data);
        if active(4) ~= 0
            plot([1 length(data)], [max max], 'm--', 'Parent', hs.ax3);
            hold on
            plot([-255 255], [max max], 'm', 'Parent', hs.ax4);
            hold on
        end
        if active(5) ~= 0
            plot([1 length(data)], [min min], 'g--', 'Parent', hs.ax3);
            hold on
            plot([-255 255], [min min], 'g', 'Parent', hs.ax4);
            hold on
        end
        if active(6) ~= 0
            height = maxHeight(data);
            plot([1 length(data)], [height height], 'y--', 'Parent', hs.ax3);
            hold on
            plot([-255 255], [height height], 'y', 'Parent', hs.ax4);
            hold on
        end
        if active(7) ~= 0
            [rz, peaks, peaksX, valleys, valleysX] = avrgProfile(data);
            plot(valleysX, valleys, 'r.', 'Parent', hs.ax3);
            hold on
            plot(peaksX, peaks, 'r.', 'Parent', hs.ax3);
            hold on
            plot([1 length(data)], [rz rz], 'k--', 'Parent', hs.ax3);
            hold on
            plot([-255 255], [rz rz],'color',[1, 0.5, 0],'Parent', hs.ax4);
            hold on
        end
        if active(8) ~= 0
            rsk = skewness(data);
            plot([-255 255], [rsk rsk],'color',[1, 0.5, 0],'Parent', hs.ax4);
            hold on
        end
        hold off
    end
    % "buttonCallback":
    % esta función es llamada cada vez que el botón de la ventana es
    % presionado o una casilla cambia de estado
    function buttonCallback(hObject, event)
        if hObject == hs.backButton
            close all
            % abrir la ventana principal
            mainLayout(1, image);
        else
            % actualizar las funciones a mostrarse
            if hObject == hs.check1
                active(1) = hObject.Value;
            elseif hObject == hs.check2
                active(2) = hObject.Value;
            elseif hObject == hs.check3
                active(3) = hObject.Value;
            elseif hObject == hs.check4
                active(4) = hObject.Value;
            elseif hObject == hs.check5
                active(5) = hObject.Value;
            elseif hObject == hs.check6
                active(6) = hObject.Value;
            elseif hObject == hs.check7
                active(7) = hObject.Value;
            elseif hObject == hs.check8
                active(8) = hObject.Value;
            end
            % actualizar las gráficas
            plotData()
        end
    end
end
