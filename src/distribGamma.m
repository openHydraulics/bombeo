function [f]=distribGamma(x,p,alfa)
  f=(1/alfa^p/factorial(p-1)).*exp(-x./alfa).*x.^(p-1);
endfunction
