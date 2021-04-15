function [GX,GY,GZ] = Curva(I,J,K,m,M,i)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    syms t

    x=str2sym(I);
    y=str2sym(J);
    z=str2sym(K);

    X=inline(x);
    Y=inline(y);
    Z=inline(z);
    
    Dm=subs(str2sym(m));
    DM=subs(str2sym(M));
    Di=subs(str2sym(i));
    
    if count(I,'t')==0 && count(J,'t')==0 && count(K,'t')==0
        GX=vpa(X(1));
        GY=vpa(Y(1));
        GZ=vpa(Z(1));
        
    elseif count(I,'t')==0 && count(J,'t')==0
        t=[Dm:Di:DM];
        d=size(t,2);
        GX(1,1:d)=vpa(X(t));
        GY(1,1:d)=vpa(Y(t));
        GZ=Z(t);    

    elseif count(I,'t')==0 && count(K,'t')==0
        t=[Dm:Di:DM];
        d=size(t,2);
        GX(1,1:d)=vpa(X(t));    
        GY=Y(t);    
        GZ(1,1:d)=vpa(Z(t));

    elseif count(J,'t')==0 && count(K,'t')==0
        t=[Dm:Di:DM];
        d=size(t,2);
        GX=X(t);    
        GY(1,1:d)=vpa(Y(t));
        GZ(1,1:d)=vpa(Z(t));   

    elseif count(I,'t')==0 
        t=[Dm:Di:DM];
        d=size(t,2);
        GX(1,1:d)=vpa(X(t));
        GY=Y(t);
        GZ=Z(t);

    elseif count(J,'t')==0 
        t=[Dm:Di:DM];
        d=size(t,2);
        GX=X(t);
        GY(1,1:d)=vpa(Y(t));    
        GZ=Z(t);

    elseif count(K,'t')==0 
        t=[Dm:Di:DM];
        d=size(t,2);
        GX=X(t);
        GY=Y(t);
        GZ(1,1:d)=vpa(Z(t));

    else
        t=[Dm:Di:DM];
        GX=X(t);
        GY=Y(t);
        GZ=Z(t);

    end

end

