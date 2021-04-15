function [V] = VectorTg(I,J,K)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    syms t

    x=str2sym(I);
    y=str2sym(J);
    z=str2sym(K);

    Dx=diff(x);
    Dy=diff(y);
    Dz=diff(z);
    
    V=strcat('[',char(Dx),']i+ [',char(Dy),']j+ [',char(Dz),']k');

end

