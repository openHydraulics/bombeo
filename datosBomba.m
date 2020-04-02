%Datos bombas
clear;clc

%Marca Grundfos
%Modelo ¿SP 77-6? 

%Altura de elevación en m
Hensayo=[71.4 70.4 65.8 60.2 53.8 48.0 42.5 69.3 73.6 77.7 81.7];

%Caudal en m3/h
Qensayo=[39.5 42.7 57.9 71.7 82.2 88.9 94.8 43 32.5 19.2 0];

%P en kW. Los 7 valores de potencia medidos se corresponden con los 7 primeros valores del caudal
Pensayo=[14.7 14.9 16.3 17.1 17.7 18.1 18.5];
rendensayo=(9806.65/3600/1000).*Hensayo(1:7).*Qensayo(1:7)./Pensayo;

figura=figure;

%Ajustes

%n polinomio a2, a1, a0
n210=[true true true];
[p210,s210]=polyfit(Qensayo,Hensayo,n210);
errorp210=transpose(sqrt(diag(s210.C)/s210.df)*s210.normr);
err_rel_p210=errorp210./p210;
disp('  a2  a1  a0  ')
disp(p210)
disp('  +-  +-  +-  ')
disp(errorp210)
disp('Error relativo')
disp(err_rel_p210)
disp('--------')
raices=roots(p210);
Qajust=1:raices(2);
Hajust=polyval(p210,Qajust);
subplot(2,2,1)
plot(Qensayo,Hensayo,'o')
axis([0 150 0 100])
xlabel('Q(m3/h)')
ylabel('H(m)')
hold on
plot(Qajust,Hajust,'-')
title('a2 a1 a0')
hold off

%n polinomio a2, a0
n20=[true false true];
[p20,s20]=polyfit(Qensayo,Hensayo,n20);
errorp20=transpose(sqrt(diag(s20.C)/s20.df)*s20.normr);
err_rel_p20=errorp20./p20;
disp('  a2  a1  a0  ')
disp(p20)
disp('  +-  +-  +-  ')
disp(errorp20)
disp('Error relativo')
disp(err_rel_p20)
disp('--------')
%raices=roots(p);
%Qajust=1:raices(2);
Hajust=polyval(p20,Qajust);
subplot(2,2,2)
plot(Qensayo,Hensayo,'o')
axis([0 150 0 100])
xlabel('Q(m3/h)')
ylabel('H(m)')
hold on
plot(Qajust,Hajust,'-')
title('a2 a0')
hold off

%n polinomio b2, b1
n21=[true true false];
[p21,s21]=polyfit(Qensayo(1:7),rendensayo,n21);
errorp21=transpose(sqrt(diag(s21.C)/s21.df)*s21.normr);
err_rel_p21=errorp21./p21;
disp('  b2  b1  b0  ')
disp(p21)
disp('  +-  +-  +-  ')
disp(errorp21)
disp('Error relativo')
disp(err_rel_p21)
disp('--------')
%raices=roots(p);
%Qajust=1:raices(2);
rendajust=polyval(p21,Qajust);
subplot(2,2,3)
plot(Qensayo(1:7),rendensayo,'o')
axis([0 150 0 1])
xlabel('Q(m3/h)')
ylabel('\eta')
hold on
plot(Qajust,rendajust,'-')
title('b2 b1')
hold off

%n polinomio a1, a0
n10=[false true true];
[p10,s10]=polyfit(Qensayo,Hensayo,n10);
errorp10=transpose(sqrt(diag(s10.C)/s10.df)*s10.normr);
err_rel_p10=errorp10./p10;
disp('  a2  a1  a0  ')
disp(p10)
disp('  +-  +-  +-  ')
disp(errorp10)
disp('Error relativo')
disp(err_rel_p10)
disp('--------')
%raices=roots(p);
%Qajust=1:raices(2);
Hajust=polyval(p10,Qajust);
subplot(2,2,4)
plot(Qensayo,Hensayo,'o')
axis([0 150 0 100])
xlabel('Q(m3/h)')
ylabel('H(m)')
hold on
plot(Qajust,Hajust,'-')
title('a1 a0')
hold off

%Se escoge el mejor ajuste de los realizados
%Tres parámetros H-Q y tres parámetros rend-Q
paramjustes=[p20 p21]
