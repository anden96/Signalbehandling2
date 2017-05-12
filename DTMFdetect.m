function result = DTMFdetect(filenumber)
%
% Funktion som avkodar DTMF signaler
% 
% Funktionen generate_secret_data.p samt DTMFgen.m m�ste finnas i samma 
% filkatalog som denna funktionen (eller i path) 
% 
% Insignaler
%    filenumber = signalfilsnummer (0-99)
%
% Utsignal 
%    Str�ng-array med detekterade symboler
%    ex. result(3,2) �r 2:a symbolen som detekterades i 3:e signalen

signals = generate_secret_data(filenumber);


for sig_idx = 1:6, % 6 signaler ska analyseras
   % figure;
   % plot(signals(:,sig_idx));
   for sym_idx=1:4, % varje signal inneh�ller 4 symboler
        
       
        % H�r fyller du i din detektionsalgoritm f�r symbol sym_idx
        % i signal sig_idx
        %
        % signals(:,sig_idx) �r signalvektorn med alla 4 symboler 
        
        detected_symbol = 'A'; % D�lig algoritm som alltid gissar 'A'!
        result(sig_idx,sym_idx) = detected_symbol; % tilldela resultat
        
    end
end
 
%% H�r under (i denna fil) l�gger ni in de hj�lpfunktioner som ni skapar
%% och anropar fr�n huvudfunktionen ovan.