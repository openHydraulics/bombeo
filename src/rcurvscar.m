%Curva característica de una bomba con velocidad de rotación variable f(Q,H,r)=0
%r=N/N0

% Debe ejecutarse previamente el script datos.m para obtener los datos a2, a1, a0, b2, b1
% y después ej. rcurvscar(50,40,[p20 p21])

%Para el punto H,Q se busca la velocidad de rotación para la que la curva característica pasa por dicho punto.
function [r,rend]=rcurvscar(H,Q,paramjustes)
  a2=paramjustes(1);
  a1=paramjustes(2);
  a0=paramjustes(3);
  b2=paramjustes(4);
  b1=paramjustes(5);
  
  %Se descartan los puntos no alcanzables por la curva
  Hmax=polyval([a2 a1 a0],Q);
  if H<=Hmax
    raices=roots([a0 a1*Q a2*Q^2-H]);
    r=raices(find(raices>0));
    rend=(b2/r^2)*Q^2+(b1/r)*Q;
  endif
endfunction
