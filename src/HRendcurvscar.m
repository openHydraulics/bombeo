%Curva característica de una bomba con velocidad de rotación variable f(Q,H,r)=0
%r=N/N0

% Debe ejecutarse previamente el script datos.m para obtener los datos a2, a1, a0, b2, b1
% y después ej. HRendcurvscar([0 20 40 60 80 100],1,[p20 p21])

%Se calculan los valores de H para Q y r. Q puede ser un vector.
function [H,rend]=HRendcurvscar(Q,r,paramjustes)
  a2=paramjustes(1);
  a1=paramjustes(2);
  a0=paramjustes(3);
  b2=paramjustes(4);
  b1=paramjustes(5);
  H=a2.*Q.^2+(a1*r).*Q+r^2*a0;
  rend=(b2/r^2).*Q.^2+(b1/r).*Q;
endfunction
