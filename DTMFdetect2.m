function result = DTMFdetect2(filenumber)
%
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
        
        detected_symbol = detekt(signals(:,sig_idx),sym_idx); % D�lig algoritm som alltid gissar 'A'!
        result(sig_idx,sym_idx) = detected_symbol; % tilldela resultat
        
    end
end
end
%% H�r under (i denna fil) l�gger ni in de hj�lpfunktioner som ni skapar
%% och anropar fr�n huvudfunktionen ovan.
function symbol = detekt(x1,sym_idx)
symbol='?';

x= x1((sym_idx-1)*640+1:960+(sym_idx-1)*640,:);


n=1;
Rp=0.5; 
% H�ga frekvenser
% 5 - 1209
% 6 - 1336Hz
% 7 - 1477Hz
% 8 - 1633Hz
% 
Wn1=[(697-5)/(4*10^3) (697+5)/(4*10^3)];
[b1,a1] = cheby1(n,Rp,Wn1);
%  w=2*pi*667/8000;

Wn2=[(770-5)/(4*10^3) (770+5)/(4*10^3)];
[b2,a2] = cheby1(n,Rp,Wn2);

Wn3=[(852-5)/(4*10^3) (852+5)/(4*10^3)];
[b3,a3] = cheby1(n,Rp,Wn3);

Wn4=[(941-5)/(4*10^3) (941+5)/(4*10^3)];
[b4,a4] = cheby1(n,Rp,Wn4);

Wn5=[(1209-5)/(4*10^3) (1209+5)/(4*10^3)];
[b5,a5] = cheby1(n,Rp,Wn5);

Wn6=[(1336-5)/(4*10^3) (1336+5)/(4*10^3)];
[b6,a6] = cheby1(n,Rp,Wn6);

Wn7=[(1477-5)/(4*10^3) (1477+5)/(4*10^3)];
[b7,a7] = cheby1(n,Rp,Wn7);

Wn8=[(1633-5)/(4*10^3) (1633+5)/(4*10^3)];
[b8,a8] = cheby1(n,Rp,Wn8);

% Filterbanken
btot=[b1;b2;b3;b4;b5;b6;b7;b8];
atot=[a1;a2;a3;a4;a5;a6;a7;a8];    

% bFrekv = [false; false; false; false; false; false; false; false];
 medel1 = [0 0 0 0];
 medel2 = [0 0 0 0];
    
for k=1:8

        y=filter(btot(k,:),atot(k,:),x);

        N=length(x);
        fs=8000;

        if(k < 5)
            medel1(k) = mean(fft(y).^2);
        else
            medel2(k-4) = mean(fft(y).^2);
        end
            
        %[value post] = max(abs(fft(y))); % Kommer beh�vas justeras n�r fler tecken ska in. Skapa en speciell vektor att studera

%         if(value-100 > 0)
%             value;
%             bFrekv(k,1) = true;
    %         figure(k)
    %         plot(abs(fft(y)))
%         end
end
    [value1 pos1] = max(medel1);
    [value2 pos2] = max(medel2);
    
    if(pos1 == 1 & pos2 == 1)
        symbol='1';
    elseif(pos1 == 1 & pos2 == 2)
        symbol='2'; 
    elseif(pos1 == 1 & pos2 == 3)
        symbol='3';
    elseif(pos1 == 1 & pos2 == 4)
        symbol='A';
    elseif(pos1 == 2 & pos2 == 1)
        symbol='4';
    elseif(pos1 == 2 & pos2 == 2)
        symbol='5';
    elseif(pos1 == 2 & pos2 == 3)
        symbol='6';
    elseif(pos1 == 2 & pos2 == 4)
        symbol='B';
    elseif(pos1 == 3 & pos2 == 1)
        symbol='7';
    elseif(pos1 == 3 & pos2 == 2)
        symbol='8';
    elseif(pos1 == 3 & pos2 == 3)
        symbol='9';
    elseif(pos1 == 3 & pos2 == 4)
        symbol='C'; 
    elseif(pos1 == 4 & pos2 == 1)
        symbol='*';
    elseif(pos1 == 4 & pos2 == 2)
        symbol='0';
    elseif(pos1 == 4 & pos2 == 3)
        symbol='#';
    elseif(pos1 == 4 & pos2 == 4)
        symbol='D';
    end

end

