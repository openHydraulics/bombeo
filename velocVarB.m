%Bombeo para un sistema. Todas las bombas a la misma velocidad de rotación.

addpath('src')

datosBomba;
Q=[];
H=[];
rot=[];
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

%Cálculo puntos óptimos de puesta en marcha/parada según bombas en funcionamiento;
rmax=[1 1 1 1 1 1 1 1 1 1];
rmin=[0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5];
rmin(1)=sqrt(c0/a0);
numBombas=numel(rmax);

rmaxant2=0.75.*rmax;
rminant2=1.5.*rmin;
rmaxant1=0.5.*rmax;
rminant1=1.25.*rmin;
z=0;
while ((sum(rmax~=rmaxant2)>0 || sum(rmin~=rminant2>0)) && z<500)
z++;
  rmaxant2=rmaxant1;
  rmaxant1=rmax;
  rminant2=rminant1;
  rminant1=rmin;
    
  for i=1:numBombas
    raicesmax=roots([a2/i^2-c2 a1*rmax(i)/i-c1 a0*rmax(i)^2-c0]);
    Qmax(i)=raicesmax(find(raicesmax>0));
    [HQmax(i),rendQmax(i)]=HRendcurvscar(Qmax(i),rmax(i),[a2/i^2 a1/i a0 b2/i^2 b1/i b0]);
    Hdivrendmax(i)=HQmax(i)/rendQmax(i);
    
    if i==1
      Qmin(i)=0;
      HQmin(i)=HQmax(i);
      r(i)=0.5*rmax(i)+0.5*rmin(i);  
    else
      Qmin(i)=Qmax(i-1);
      HQmin(i)=HQmax(i);
      [rmin(i),rendQmin(i)]=rcurvscar(HQmin(i),Qmin(i),[a2/i^2 a1/i a0 b2/i^2 b1/i b0]);
      Hdivrendmin(i)=HQmin(i)/rendQmin(i);
      if Hdivrendmax(i-1)>Hdivrendmin(i)
        rmax(i-1)=rmax(i-1)-0.001;
        rmin(i)=rmin(i)+0.001;
      else
        rmax(i-1)=rmax(i-1)+0.001;
        if rmax(i-1)>1
          rmax(i-1)=1;
        endif
        rmin(i)=rmin(i)-0.001;
      endif
    endif
  endfor
endwhile

disp('Num. iteracciones')
disp(z)
disp('Vel. rotación max. y min. - puntos de cambio')
disp([rmax; rmin])
  
%Obtención de las curvas completas
for i=1:numBombas
  if i==1
    Qcalc=1:1:Qmax(i);
  else
    Qcalc=Qmax(i-1):1:Qmax(i);
  endif
    
  [HQmax(i),rendQmax(i)]=HRendcurvscar(Qmax(i),rmax(i),[a2/i^2 a1/i a0 b2/i^2 b1/i b0]);
  Hcalc=ones(1,numel(Qcalc)).*HQmax(i);
    
  rcalc=[];
  rendcalc=[];
  
  for j=1:numel(Qcalc)
    [rVar,rendVar]=rcurvscar(Hcalc(j),Qcalc(j),[a2/i^2 a1/i a0 b2/i^2 b1/i b0]);
    rcalc=[rcalc rVar];
    rendcalc=[rendcalc rendVar];
  endfor
    
  Q=[Q Qcalc];
  H=[H Hcalc];
  rot=[rot rcalc];
  rend=[rend rendcalc];
  %rend=ones(1,numel(Q));

endfor
 
EneVol=9806.65/3.6e6.*H./rend;
Henvol=c2.*Q.^2+c1.*Q+c0;

figura4=figure;
subplot(1,2,1)
[ax,lines1,lines2]=plotyy(Q,H,Q,EneVol);
xlabel("Q(m^{3}/h)")
ylabel(ax(1), "H(m)")
ylabel(ax(2), "E/V (kWh/m^{3})")

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
xlabel("Q(m^{3}/h)")
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





























































































































































