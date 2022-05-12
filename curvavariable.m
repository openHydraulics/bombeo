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

figura2=figure();

[ax,lines1,lines2]=plotyy(Q,resultadoH,Q,resultadoRend);
xlabel("Q(m^{3}/h)")
ylabel(ax(1), "H(m)",'color','b')
ylabel(ax(2), "rend.",'color','r')
set(ax(1),'Xlim',[0 150])
set(ax(1),'Ylim',[0 80])
set(ax(2),'Xlim',[0 150])
set(ax(2),'Ylim',[0 0.8])
set(lines1,'color','b')
set(lines2,'color','r')
text(Q(1),resultadoH(7,1),'r=1')
text(Q(1),resultadoH(6,1),'r=0.95')
text(Q(1),resultadoH(5,1),'r=0.9')
text(Q(1),resultadoH(4,1),'r=0.85')
text(Q(1),resultadoH(3,1),'r=0.8')
text(Q(1),resultadoH(2,1),'r=0.75')
text(Q(1),resultadoH(1,1),'r=0.7')
text(Q(end),resultadoRend(7,end)*100,'r=1')

