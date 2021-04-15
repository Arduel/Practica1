function [Eck,Ecr,pk,pr] = CurV(I,J,K,nk,nr)
%UNTITLED4 Summary of this function goes here
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
    
    dx2=simplify(expand(dx.^2));
    dy2=simplify(expand(dy.^2));
    dz2=simplify(expand(dz.^2));
    
    sd3=simplify(dx2+dy2+dz2);
    md=simplify(sqrt(sd3));
    md3=simplify(md.^3);
    
    i=simplify(expand((dy.*d2z)-(dz.*d2y)));
    j=simplify(expand(-((dx.*d2z)-(dz.*d2x))));
    k=simplify(expand((dx.*d2y)-(dy.*d2x)));
    
    i2=simplify(expand(i.^2));
    j2=simplify(expand(j.^2));
    k2=simplify(expand(k.^2));
    
    Sum=simplify(expand(i2+j2+k2));
    Mod=simplify(expand(sqrt(Sum)));
    
    EcK=simplify(Mod./md3);
    EcR=simplify(md3./Mod);
    
    Eck=char(EcK);
    Ecr=char(EcR);
    
    if size(nk,2)==0
        pk='Null';
    else
        eck=inline(EcK);
        t=subs(str2sym(nk));
        pk=char(vpa(eck(t)));
    end
    
    if size(nr,2)==0
        pr='Null';
    else
        eck=inline(EcR); 
        t=subs(str2sym(nr));
        pr=strcat('[',char(vpa(eck(t))),'] u');
    end
    
end

