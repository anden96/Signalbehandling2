%% R�j upp lite 
x = DTMFgen('1',40,40,0);

n=2;
Rp=3;
% L�ga frekvenserna
% 1 - 697Hz
% 2- 770Hz
% 3- 852Hz
% 4 - 941Hz
% H�ga frekvenser
% 5 - 1209
% 6 - 1336Hz
% 7 - 1477Hz
% 8 - 1633Hz
% 
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
for k=1:8
    y=filter(btot(k,:),atot(k,:),x)
    figure(k)
    plot(abs(fft(y)))
    
    N=960;
    fs=8000;
    
    
end


%%
% y=conv(x,h)
y1=filter(b1,a1,x)
y2=filter(b5,a5,x)
figure(1)
plot(abs(fft(y1)))
figure(2)
plot(abs(fft(y2)))




knapp = [false false false false false false false false];

test1 = abs(fft(y1));
[value1 k1] = max(test1);
val1 = k1*fs/N;

test2 = abs(fft(y2));
[value2 k2] = max(test2);
val2 = k2*fs/N;

%H=100 �r satt som "gr�nsv�rde"
knapp(1) = ge(value1-100,0);
knapp(5) = ge(value2-100,0);