%Curvas velocidad rotación variable

addpath('src')

datosBomba;

resultadoH=[];
resultadoRend=[];

%Caudal 
raices=roots(p20);
Q=0:1:raices(find(raices>0));

for r=0.7:0.05:1
  [H,rend]=HRendcurvscar(Q,r,[p20 p21]);
  resultadoH=[resultadoH;H];
  resultadoRend=[resultadoRend;rend];
endfor

%Representación gráfica
figure;
[ax,lines1,lines2]=plotyy(Q,resultadoH,Q,resultadoRend);
xlabel("Q(m³/h)")
ylabel(ax(1), "H(m)")
ylabel(ax(2), "rend.")
set(ax(1),'Xlim',[0 150])
set(ax(1),'Ylim',[0 80])
set(ax(2),'Xlim',[0 150])
set(ax(2),'Ylim',[0 0.8])
set(lines1,'color','b')
set(lines2,'color','r')
