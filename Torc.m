function [EcT,EvT] = Torc(I,J,K,T)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    syms t a b

    x=str2sym(I);
    y=str2sym(J);
    z=str2sym(K);

    dx=diff(str2sym(I));
    dy=diff(str2sym(J));
    dz=diff(str2sym(K));
    
    d2x=diff(dx);
    d2y=diff(dy);
    d2z=diff(dz);
    
    d3x=diff(d2x);
    d3y=diff(d2y);
    d3z=diff(d2z);
    
    dx2=simplify(expand(dx.^2));
    dy2=simplify(expand(dy.^2));
    dz2=simplify(expand(dz.^2));
    
    sd3=simplify(dx2+dy2+dz2);
    md=simplify(sqrt(sd3));
    md3=simplify(md.^3);
    
    i=simplify(expand((dy.*d2z)-(dz.*d2y)));
    j=simplify(expand(-((dx.*d2z)-(dz.*d2x))));    %Producto cruz (dx) x (d2x)
    k=simplify(expand((dx.*d2y)-(dy.*d2x)));
    
    i2=simplify(expand(i.^2));
    j2=simplify(expand(j.^2));
    k2=simplify(expand(k.^2));

    Sum=simplify(expand(i2+j2+k2));
    Mod=simplify(expand(sqrt(Sum)));
    
    num=simplify((d3x.*i)+(d3y.*j)+(d3z.*k)); %[(dt)x(d2t)].(d3t)
    den=simplify(Mod.^2);
    
    EcT=char(simplify(num./den));
    
    if size(T,2)==0
        EvT='Null';
    else
        Ev=inline(EcT);    
        t=subs(str2sym(T)); 
        EvT=char(vpa(Ev(t)));
    end
    
end

