%% Röj upp lite 
x1 = DTMFgen('*2D9',40,40,1);
% figure(1)
% plot(x1)
% figure(2)
%  plot(abs(fft(x1)));

% Kommentar från Rasmus

disp('')

n=2;
Rp=3;
% Låga frekvenserna
% 1 - 697Hz
% 2- 770Hz
% 3- 852Hz
% 4 - 941Hz
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

%%
Wn1=[(697-10)/(4*10^3) (697+10)/(4*10^3)];
[b1,a1] = cheby1(n,Rp,Wn1);
%  w=2*pi*667/8000;

Wn2=[(770-10)/(4*10^3) (770+10)/(4*10^3)];
[b2,a2] = cheby1(n,Rp,Wn2);

Wn3=[(852-10)/(4*10^3) (852+10)/(4*10^3)];
[b3,a3] = cheby1(n,Rp,Wn3);

Wn4=[(941-10)/(4*10^3) (941+10)/(4*10^3)];
[b4,a4] = cheby1(n,Rp,Wn4);

Wn5=[(1209-10)/(4*10^3) (1209+10)/(4*10^3)];
[b5,a5] = cheby1(n,Rp,Wn5);

Wn6=[(1336-10)/(4*10^3) (1336+10)/(4*10^3)];
[b6,a6] = cheby1(n,Rp,Wn6);

Wn7=[(1477-10)/(4*10^3) (1477+10)/(4*10^3)];
[b7,a7] = cheby1(n,Rp,Wn7);

Wn8=[(1633-10)/(4*10^3) (1633+10)/(4*10^3)];
[b8,a8] = cheby1(n,Rp,Wn8);

% Filterbanken
btot=[b1;b2;b3;b4;b5;b6;b7;b8];
atot=[a1;a2;a3;a4;a5;a6;a7;a8];

%%
length(x1)
%%
% Går igeonom 4 st symboler
for iterator=1:4
% 
    x= x1((iterator-1)*640+1:960+(iterator-1)*640,:);

%  C1=(iterator-1)*640+1
%  C2=960+(iterator-1)*640


    % FÖr att lagra frekvenser
    bFrekv = [false; false; false; false; false; false; false; false];


    % Kollar filter 
    for k=1:8
        
        y=filter(btot(k,:),atot(k,:),x);

        N=length(x);
        fs=8000;

        [value post] = max(abs(fft(y))); % Kommer behövas justeras när fler tecken ska in. Skapa en speciell vektor att studera

        if(value-100 > 0)
            value;
            bFrekv(k,1) = true;
    %         figure(k)
    %         plot(abs(fft(y)))
        end
    end
    
    if(bFrekv(1) & bFrekv(5))
        disp('Siffran 1')
    elseif(bFrekv(1) & bFrekv(6))
        disp('Siffran 2')
    elseif(bFrekv(1) & bFrekv(7))
        disp('Siffran 3')
    elseif(bFrekv(1) & bFrekv(8))
        disp('A')
    elseif(bFrekv(2) & bFrekv(5))
        disp('Siffran 4')
    elseif(bFrekv(2) & bFrekv(6))
        disp('Siffran 5')
    elseif(bFrekv(2) & bFrekv(7))
        disp('Siffran 6')
    elseif(bFrekv(2) & bFrekv(8))
        disp('B')
    elseif(bFrekv(3) & bFrekv(5))
        disp('Siffran 7')
    elseif(bFrekv(3) & bFrekv(6))
        disp('Siffran 8')
    elseif(bFrekv(3) & bFrekv(7))
        disp('Siffran 9')
    elseif(bFrekv(3) & bFrekv(8))
        disp('Siffran C')
    elseif(bFrekv(4) & bFrekv(5))
        disp('*')
    elseif(bFrekv(4) & bFrekv(6))
        disp('Siffran 0')
    elseif(bFrekv(4) & bFrekv(7))
        disp('#')
    elseif(bFrekv(4) & bFrekv(8))
        disp('D')
    end

end








%%
% y=conv(x,h)
y1=filter(b1,a1,x)
y2=filter(b5,a5,x)
figure(1)
plot(abs(fft(y1)))
figure(2)
plot(abs(fft(y2)))


test1 = abs(fft(y1));
[value1 k1] = max(test1);
val1 = k1*fs/N;
value1

test2 = abs(fft(y2));
[value2 k2] = max(test2);
val2 = k2*fs/N;

%H=100 är satt som "gränsvärde"
knapp(1) = ge(value1-100,0);
knapp(5) = ge(value2-100,0);