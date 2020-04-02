%Curva característica de una bomba con velocidad de rotación variable f(Q,H,r)=0
%r=N/N0

% Debe ejecutarse previamente el script datos.m para obtener los datos a2, a1, a0, b2, b1
% y después ej. Qcurvscar([0 20 40 60 80 100],1,[p20 p21])

%Calcula el caudal Q, para una altura de elevación H con un velocidad de rotación r
function [Q,rend]=Qcurvscar(H,r,paramjustes)
  a2=paramjustes(1);
  a1=paramjustes(2);
  a0=paramjustes(3);
  b2=paramjustes(4);
  b1=paramjustes(5);
  %No se calculan aquellos valores de H inalcanzables para una velocidad de rotación r.
  if H<=a0*r^2
    raices=roots([a2 a1*r a0*r^2-H]);
    Q=raices(find(raices>0));
    rend=(b2/r^2)*Q^2+(b1/r)*Q;
  endif
endfunction
