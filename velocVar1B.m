%Bombeo para un sistema. Todas las bombas a la misma velocidad de rotación.

addpath('src')

datosBomba;

Q=[];
H=[];
Hbombeo=[];
rot=[];
rotMinMax=[];
rend=[];

%Envolvente superior de los puntos H0(m),Q(m3/h) del sistema (ver tema Red de distribución)
c0=37;
c1=0;
c2=(47-c0)/900^2;

a2=paramjustes(1);
a1=paramjustes(2);
a0=paramjustes(3);
b2=paramjustes(4);
b1=paramjustes(5);
b0=paramjustes(6);

%Cálculo caudal máximo según i bombas en funcionamiento;
r=[1 1 1 1 1 1 1 1 1 1];
numBombas=numel(r);

for i=1:numBombas
  raices=roots([a2/i^2-c2 a1*r(i)/i-c1 a0*r(i)^2-c0]);
  Qmax(i)=raices(find(raices>0));
  
  if i==1
    Qcalc=1:1:Qmax(i);
  else
    Qcalc=Qmax(i-1):1:Qmax(i);
  endif
    
  [HQmax,rendQmax]=HRendcurvscar(Qmax(i),r(i),[a2/i^2 a1/i a0 b2/i^2 b1/i b0]);
  Hcalc=ones(1,numel(Qcalc)).*HQmax;
    
  rcalc=[];
  rendcalc=[];
  
  rMin=1; rMax=0;
  for j=1:numel(Qcalc)
    [rVar,rendVar]=rcurvscar(Hcalc(j),Qcalc(j),[a2/i^2 a1/i a0 b2/i^2 b1/i b0]);
    if rVar > rMax
      rMax=rVar;
    endif
    if rVar < rMin
      rMin=rVar;
    endif
    rcalc=[rcalc rVar];
    rendcalc=[rendcalc rendVar];
  endfor
  
  Hbombeo=[Hbombeo HQmax];
  rotMinMax=[rotMinMax [rMin; rMax]];
    
  Q=[Q Qcalc];
  H=[H Hcalc];
  rot=[rot rcalc];
  rend=[rend rendcalc];
  %rend=ones(1,numel(Q));

endfor

disp('Altura presión y veloc. rot. Max. y Min. puesta marcha/parada')
disp('1->2  2->3  3->4  4->5 ...')
disp('2->1  3->2  4->3  5->4 ...')
disp([Hbombeo])
disp([rotMinMax])
    
EneVol=9806.65/3.6e6.*H./rend;
Henvol=c2.*Q.^2+c1.*Q+c0;

figura3=figure;
subplot(1,2,1)
[ax,lines1,lines2]=plotyy(Q,H,Q,EneVol);
xlabel("Q(m3/h)")
ylabel(ax(1), "H(m)")
ylabel(ax(2), "E/V (kWh/m3)")

set(ax(1),'Xlim',[0 Qmax(end)])
set(ax(1),'Ylim',[0 80])
set(ax(2),'Xlim',[0 Qmax(end)])
set(ax(2),'Ylim',[0 0.8])
set(lines1,'color','b')
set(lines2,'color','r')
hold on
plot(Q,Henvol,'g--')
hold off


subplot(1,2,2)
[ax,lines1,lines2]=plotyy(Q,rot,Q,rend);
xlabel("Q(m3/h)")
ylabel(ax(1), "r")
ylabel(ax(2), "rend")
set(ax(1),'Xlim',[0 Qmax(end)])
set(ax(1),'Ylim',[0 1])
set(ax(2),'Xlim',[0 Qmax(end)])
set(ax(2),'Ylim',[0 0.8])
set(lines1,'color','b')
set(lines2,'color','r')
hold on
plot(Q,Henvol,'g--')
hold off





























































































































































