%Bombeo para un sistema
addpath('src')

datosBomba;

Q=[];
H=[];
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
  Hcambio(i)=polyval([a2/i^2 a1*r(i)/i a0*r(i)^2],Qmax(i));
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

figura4=figure
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

disp('Altura presión puesta marcha/parada')
disp('1->2  2->3  3->4  4->5')
disp('2->1  3->2  4->3  5->4')
disp(Hcambio)

Qcambio1=[0 Qmax];
Qcambio2=[Qmax 0];
Qmedio=(Qcambio1+Qcambio2)./2;

for i=1:numBombas
  if i==1
    cadena=strcat(num2str(i)," bomba");
  else
    cadena=strcat(num2str(i)," bombas");
  endif
  text(Qmedio(i),polyval([a2/i^2 a1*r(i)/i a0*r(i)^2],Qmedio(i)),cadena);
endfor





























































































































































