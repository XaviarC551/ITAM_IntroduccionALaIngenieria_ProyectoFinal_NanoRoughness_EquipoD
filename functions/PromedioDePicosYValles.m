function [Rz,vectR] = PromedioDePicosYValles(vectf,promedio)
%Funcion que encuentra todos los picos y todos los valles de la grafica
%para calcular el promedio de los picos y valles

m=length(vectf); 
p=0; %contador de picos
v=0; %contador de valles
sumapicos=0; %suma el valor que hay en un pico
sumavalles=0; %suma el valor que hay en los valles


%encontramos el primer punto de corte
bandera=0;
n=1; %first
while(bandera==0 & n<m)
    if(vectf(n)>=promedio & vectf(n+1)<=promedio)
        bandera=1;
    else
        if(vectf(n)<=promedio & vectf(n+1)>=promedio)
            bandera=1;
        else
            n=n+1;
        end
    end
end 
f=n+1; %primer punto de corte

%encontramos el ultimo punto de corte
bandera2=0;
n=m;
while(bandera2==0 & n>1)
    if(vectf(n)>=promedio & vectf(n-1)<=promedio)
        bandera2=1;
    else
        if(vectf(n)<=promedio & vectf(n-1)>=promedio)
            bandera2=1;
        else
            n=n-1;
        end
    end
end 
u=n; %ultimo punto de corte

i=f;
iaux=f;
x=1;
while(i<u)
   if(vectf(i)<promedio)
        j=1;
        while(i<u & vectf(i)<promedio)
             aux(j)=vectf(i);
             i=i+1;
             j=j+1;           
        end
        %cuando sale del while es hora de sumar un valle y sacar el menor
        v=v+1;
        valorMenor=min(vectf(iaux:i));
        w=iaux;
        while(w<i & vectf(w)~=valorMenor)
            w=w+1;
        end
        vectR(x)=w;
        x=x+1;
        iaux=i;

        %sumamos ese valor menor a la sumatoria de valles
        sumavalles=sumavalles+valorMenor;
        disp(valorMenor)
    else
        j=1;
        while(i<u & vectf(i)>promedio)
             aux(j)=vectf(i);
             i=i+1;
             j=j+1;           
        end
        %cuando sale del while es hora de sumar un valle y sacar el mayor
        
        p=p+1;
        valorMayor=max(vectf(iaux:i));
        w=iaux;
        while(w<i & vectf(w)~=valorMayor)
            w=w+1;
        end
        vectR(x)=w;
        x=x+1;
        iaux=i;
        
        %sumamos ese valor mayor a la sumatoria de picos
        disp(valorMayor)
        sumapicos=sumapicos+valorMayor;
    end
    
end

s=sumapicos+sumavalles;
disp(s)
Rz=(s)/(p+v);
end