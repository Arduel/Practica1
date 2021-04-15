function [Ec,L] = LongA(I,J,K,A,B)
    syms t a b

    x=str2sym(I);
    y=str2sym(J);
    z=str2sym(K);

    Dx=diff(str2sym(I));
    Dy=diff(str2sym(J));
    Dz=diff(str2sym(K));
    
    D2x=expand(Dx.^2);
    D2y=expand(Dy.^2);
    D2z=expand(Dz.^2);
    
    Sum=simplify(D2x+D2y+D2z);
    Mod=simplify(expand(sqrt(Sum)));
    Ec=char(simplify(int(Mod,b,a)));
    
    if size(A,2)==0 || size(B,2)==0           
        L='Null';
    else
        a=subs(str2sym(A)); %lineas funcionales
        b=subs(str2sym(B));
        ec=vpa(subs(int(Mod,[b a]))); %Linea funcional con ambos limites incluidos pero error en exp
       
        L=strcat('[',char(abs(ec)),'] u');%linea funcional
    end

end

