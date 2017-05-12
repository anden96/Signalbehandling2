function  [x] = DTMFgen(symbols,duration,spacing,variance);
% function  [x] = DTMFgen(symbols,duration,spacing,variance);
%
% Generation of DTMF signal with multiple symbols assuming a sample
% rate of 8 kHz including a noise signal with a zero mean and a
% Gaussian ditribution
%
% The generated signal is composed of spacing, symbol, spacing ,...,
% symbol, spacing 
%
% Inputs: 
%        symbols   = A string with the symbols to send from the
%                    alphabet '0123456789#*ABCD'
%        duration  = Time of duration of each symbol (in
%                    milliseconds)
%        spacing   = Time of spacing between each symbol (in
%                    milliseconds)
%        variance  = variance of the added noise signal with a
%                      
%
%  Revision B

if nargin<1,
  disp('function  [x] = DTMFgen(symbols,duration,spacing, variance)');
  return;
end


if nargin<4,
  error('You must specify all four input arguments: Symbols duration spacing and variance');
end

fs = 8e3;
spalen = fs/1e3*spacing;
durlen = duration*fs/1e3;
sigma = sqrt(variance);


x = sigma*randn(spalen,1);

for sidx = 1:length(symbols),
  switch symbols(sidx)
    case {'1' '2' '3' 'A'}
     fl = 697;
    case {'4' '5' '6' 'B'}
     fl = 770;
    case {'7' '8' '9' 'C'}
     fl = 852;
    case {'*' '0' '#' 'D'}
     fl = 941;
    otherwise 
     error('Unknown symbol (valid symbol set is : 1234567890*#ABCD');
  end
  
  switch symbols(sidx)
    case {'1' '4' '7' '*'}
     fu = 1209;
    case {'2' '5' '8' '0'}
     fu = 1336;
    case {'3' '6' '9' '#'}
     fu = 1477;
    case {'A' 'B' 'C' 'D'}
     fu = 1633;
   end
   
   t = (0:durlen-1)'/fs;
   x = [x; sin(2*pi*fl*t)+sin(2*pi*fu*t)+sigma*randn(durlen,1); ...
	sigma*randn(spalen,1) ];
   
 end
 

  
     


