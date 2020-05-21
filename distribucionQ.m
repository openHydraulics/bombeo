clear;clc
close all
%Aplicación de la distribGamma

addpath('src')

Q=0:1:500;
desvs=[100 80 60 60 75 105 125];
medias=[150 150 150 200 200 200 200];

fdist=[];

for i=1:numel(desvs)
  varianza=desvs(i)^2;
  media=medias(i);
  
  alfa=varianza/media;
  p=floor(media/alfa);
  
  f=distribGamma(Q,p,alfa);
  fdist=[fdist;f];%./sum(f)];
    
endfor

plot(Q,fdist);
xlabel('Q(m3/h)')
ylabel('frecuencia')