%Bombeo para un sistema
addpath('src')

datosBomba;

Q=[];
H=[];
rend=[];

%Envolvente superior de los puntos H0(m),Q(m3/h) del sistema (ver tema Red de distribución)
c0=40;
c1=0;
c2=(60-40)/400^2;

a2=paramjustes(1);
a1=paramjustes(2);
a0=paramjustes(3);
b2=paramjustes(4);
b1=paramjustes(5);
b0=paramjustes(6);

%Cálculo caudal máximo según i bombas en funcionamiento;
r=[1 1 1 1 1 1];
numBombas=numel(r);
for i=1:numBombas
  raices=roots([a2/i^2-c2 a1*r(i)/i-c1 a0*r(i)-c0]);
  Qmax(i)=raices(find(raices>0));
  if i==1
    Qcalc=1:1:Qmax(i);
  else
    Qcalc=Qmax(i-1):1:Qmax(i);
  endif
  
  [Hcalc,rendcalc]=HRendcurvscar(Qcalc,r(i),[a2/i^2 a1/i a0 b2/i^2 b1/i b0]);
  
  Q=[Q Qcalc];
  H=[H Hcalc];
  rend=[rend rendcalc];
endfor

EneVol=9806.65/3.6e6.*H./rend;
Henvol=c2.*Q.^2+c1.*Q+c0;

figure
[ax,lines1,lines2]=plotyy(Q,H,Q,EneVol);
xlabel("Q(m³/h)")
ylabel(ax(1), "H(m)")
ylabel(ax(2), "rend.")
set(ax(1),'Xlim',[0 Qmax(end)])
set(ax(1),'Ylim',[0 80])
set(ax(2),'Xlim',[0 Qmax(end)])
set(ax(2),'Ylim',[0 0.8])
set(lines1,'color','b')
set(lines2,'color','r')
hold on
plot(Q,Henvol,'g--')
hold off































































































































































