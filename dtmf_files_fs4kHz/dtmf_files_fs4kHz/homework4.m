clc
clear
clear all;
%asci=97;
%basilan tuslar i�in matris olu�turuldu
sonuclar_matrisi = zeros(16,4) 
sayac=1;
%dosyalar� otomatik okumak i�in ascii kodlar� kullan�ld�
for k=97:112; 
    clc
    filename = sprintf('%c.data',k) 
    [a,delimiterOut]=importdata(filename)
     
    %%plot(a)
    ffta=fft(a);
    
    %%figure
    %%plot(abs(ffta));

    %128. elemandan sonraki elemanlar s�f�rland� 
    %��nk� biz sadece 128.elemana kadar bakt�k
    for i=129:256 
        ffta(i)=0;
    end
    %grafi�in 1. maksimum de�eri bulundu.
    [maxValue, maxIndex] = max(ffta); 
    %bulunan 1.maksimum de�eri 2.maksimumu bulmak i�in s�f�rland�
    ffta(maxIndex)=0; 
    %grafi�in 2. maksimum de�eri bulundu.
    [maxValue1, maxIndex1] = max(ffta);
    temp=0;
    temp1=0; 
    %bu b�l�mde ilk bas�lan tu�un sat�r olarak ayarlanmas� sa�land�
    if maxIndex>maxIndex1
       temp=maxIndex;
       maxIndex=maxIndex1;
       maxIndex1=temp;
       temp1=maxValue;
       maxValue=maxValue1;
       maxValue1=temp1;
       temp=0;
       temp1=0;
    end

    %bu b�l�mde frekans1 ve frekans2 bulundu.
    f1=fix(maxIndex/128*2000);
    f2=fix(maxIndex1/128*2000);

    %bu b�l�mde buldupumuz frekasn1 in hangi sat�ra daha yak�n oldu�unu
    %bulmak i�in i�lmeler yapt�k
    satir1=abs (697-f1); 
    satir2=abs (770-f1); 
    satir3=abs (852-f1); 
    satir4=abs (941-f1); 
    %bu b�l�mde buldupumuz frekasn2 nin hangi s�tuna daha yak�n oldu�unu
    %bulmak i�in i�lmeler yapt�k
    sutun1=abs (1209-f2); 
    sutun2=abs (1336-f2); 
    sutun3=abs (1477-f2); 
    sutun4=abs (1633-f2); 

    satirnumara=0;
    sutunnumara=0;
    %buldu�umuz frekans hangi sat�ra denk geliyorsa onu bulduk
    if (satir1<satir2 && satir1<satir3 && satir1<satir4)
        satirnumara=1;
    elseif(satir2<satir1 && satir2<satir3 && satir2<satir4)
        satirnumara=2;
    elseif(satir3<satir1 && satir3<satir2 && satir3<satir4)
        satirnumara=3;
    else
        satirnumara=4;
    end

    %buldu�umuz frekans hangi s�tuna denk geliyorsa onu bulduk
    if (sutun1<sutun2 && sutun1<sutun3 && sutun1<sutun4)
        sutunnumara=1;
    elseif(sutun2<sutun1 && sutun2<sutun3 && sutun2<sutun4)
        sutunnumara=2;
    elseif(sutun3<sutun1 && sutun3<sutun2 && sutun3<sutun4)
        sutunnumara=3;
    else
        sutunnumara=4;
    end
    %sonuclar� olu�turdu�umuz sonu� matrisine yazd�rd�k
    sonuclar_matrisi(sayac,1)=satirnumara;
    sonuclar_matrisi(sayac,2)=sutunnumara;
    sonuclar_matrisi(sayac,3)=f1;
    sonuclar_matrisi(sayac,4)=f2;
    sayac=sayac+1;
    clc
    %sound(a,4000)
end    

%son olarak b�t�n dosyalar�n okundu ve sonuclar matrisine buldu�umuz
%sonuclar aktar�ld� ve bizde sonuclar matrisini ekrana yazd�rdk.
asci=97;
for j=1:16
    fprintf("%c dosyas�nda f1=%d f2=%d bas�lan tu� %d.sat�r %d.sutun \n",asci,sonuclar_matrisi(j,3),sonuclar_matrisi(j,4),sonuclar_matrisi(j,1),sonuclar_matrisi(j,2));
    asci=asci+1;
end