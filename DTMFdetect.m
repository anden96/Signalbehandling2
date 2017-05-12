function result = DTMFdetect(filenumber)
%
% Funktion som avkodar DTMF signaler
% 
% Funktionen generate_secret_data.p samt DTMFgen.m måste finnas i samma 
% filkatalog som denna funktionen (eller i path) 
% 
% Insignaler
%    filenumber = signalfilsnummer (0-99)
%
% Utsignal 
%    Sträng-array med detekterade symboler
%    ex. result(3,2) är 2:a symbolen som detekterades i 3:e signalen

signals = generate_secret_data(filenumber);


for sig_idx = 1:6, % 6 signaler ska analyseras
   % figure;
   % plot(signals(:,sig_idx));
   for sym_idx=1:4, % varje signal innehåller 4 symboler
        
       
        % Här fyller du i din detektionsalgoritm för symbol sym_idx
        % i signal sig_idx
        %
        % signals(:,sig_idx) är signalvektorn med alla 4 symboler 
        
        detected_symbol = 'A'; % Dålig algoritm som alltid gissar 'A'!
        result(sig_idx,sym_idx) = detected_symbol; % tilldela resultat
        
    end
end
 
%% Här under (i denna fil) lägger ni in de hjälpfunktioner som ni skapar
%% och anropar från huvudfunktionen ovan.