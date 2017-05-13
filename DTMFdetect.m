function result = DTMFdetect(filenumber)
%
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
        
        detected_symbol = detekt(signals(:,sig_idx),sym_idx); % Dålig algoritm som alltid gissar 'A'!
        result(sig_idx,sym_idx) = detected_symbol; % tilldela resultat
        
    end
end
end
%% Här under (i denna fil) lägger ni in de hjälpfunktioner som ni skapar
%% och anropar från huvudfunktionen ovan.
function symbol = detekt(x1,sym_idx)
symbol='?';

x= x1((sym_idx-1)*640+1:960+(sym_idx-1)*640,:);


n=2;
Rp=0.5; 
% Höga frekvenser
% 5 - 1209
% 6 - 1336Hz
% 7 - 1477Hz
% 8 - 1633Hz
% 
frekvenser=[697;770;852;941;1209;1336;1477;1633];
btot=zeros(8,5);
atot=zeros(8,5);
for k=1:length(frekvenser)
    Wn=[(frekvenser(k,1)-10)/(4*10^3) (frekvenser(k,1)+10)/(4*10^3)];
    [b a] = cheby1(n,Rp,Wn);
    btot(k,:)=b;
    atot(k,:)=a;
    
end

 bFrekv = [false; false; false; false; false; false; false; false];
    
for k=1:8
    y=filter(btot(k,:),atot(k,:),x);
    N=length(x);
    fs=8000;
    [value post] = max(abs(fft(y)));

        if(value-100 > 0)
            value;
            bFrekv(k,1) = true;
    %         figure(k)
    %         plot(abs(fft(y)))
        end
    end
    
    if(bFrekv(1) & bFrekv(5))
        symbol='1';
    elseif(bFrekv(1) & bFrekv(6))
        symbol='2'; 
    elseif(bFrekv(1) & bFrekv(7))
        symbol='3';
    elseif(bFrekv(1) & bFrekv(8))
        symbol='A';
    elseif(bFrekv(2) & bFrekv(5))
        symbol='4';
    elseif(bFrekv(2) & bFrekv(6))
        symbol='5';
    elseif(bFrekv(2) & bFrekv(7))
        symbol='6';
    elseif(bFrekv(2) & bFrekv(8))
        symbol='B';
    elseif(bFrekv(3) & bFrekv(5))
        symbol='7';
    elseif(bFrekv(3) & bFrekv(6))
        symbol='8';
    elseif(bFrekv(3) & bFrekv(7))
        symbol='9';
    elseif(bFrekv(3) & bFrekv(8))
        symbol='C'; 
    elseif(bFrekv(4) & bFrekv(5))
        symbol='*';
    elseif(bFrekv(4) & bFrekv(6))
        symbol='0';
    elseif(bFrekv(4) & bFrekv(7))
        symbol='#';
    elseif(bFrekv(4) & bFrekv(8))
        symbol='D';
    end

end

