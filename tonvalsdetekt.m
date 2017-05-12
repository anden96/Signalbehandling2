x = DTMFgen('1',40,40,0)
figure(3)
plot(x)
n=2;
Rp=3;
Wn1=[(697-10)/(4*10^3) (697+10)/(4*10^3)];
[b1,a1] = cheby1(n,Rp,Wn)
%  w=2*pi*667/8000;

Wn2=[(1209-10)/(4*10^3) (1209+10)/(4*10^3)];
[b2,a2] = cheby1(n,Rp,Wn2)


% y=conv(x,h)
y1=filter(b1,a1,x)
y2=filter(b2,a2,x)
figure(1)
plot(abs(fft(y1)))
figure(2)
plot(abs(fft(y2)))


%%
N=length(x)
fs=8000
test = abs(fft(y1))
[value k] = max(test)
plot(test)
% f=0:fs/N:fs-fs/N

k*fs/N
% Använda positionen antalet sample N och f_s för att beräkna frekvensen 
