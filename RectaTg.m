function [Xx,Yy,Zz,TGx,TGy,TGz,VEv] = RectaTg(I,J,K,n)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    syms t

    x=str2sym(I);
    y=str2sym(J);
    z=str2sym(K);

    Dx=diff(x);
    Dy=diff(y);
    Dz=diff(z);

    X=inline(x);
    Y=inline(y);
    Z=inline(z);

    dx=inline(Dx);
    dy=inline(Dy);
    dz=inline(Dz);

    t=subs(str2sym(n)); %Valor del punto a conocer del vector tangente

    Xx=X(t);    %\
    Yy=Y(t);    % |  Coordenadas de la función en el punto t
    Zz=Z(t);    %/ 

    xdx=dx(t);  %\
    ydy=dy(t);  % |  Coordenadas del vector tg en el punto t
    zdz=dz(t);  %/
    
    old = digits(3);
    Vtg=[vpa(xdx),vpa(ydy),vpa(zdz)];
    VEv=strcat('[',char(Vtg(1,1)),']i+ [',char(Vtg(1,2)),']j+ [',char(Vtg(1,3)),']k');
    
    TGx=zeros(1,3);
    TGy=zeros(1,3);
    TGz=zeros(1,3);
    
    %Ecuación de la recta tg
    
    for j=1:1:3
        TGx(1,j)= Xx + (j-2)*xdx;
        TGy(1,j)= Yy + (j-2)*ydy;
        TGz(1,j)= Zz + (j-2)*zdz;
    end
end

