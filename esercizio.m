clc
clear 

%% DATI 

load("FB_103.mat")
l1 = C12_poF08_X.x_values.number_of_values;   % lenght vettore
C12 = C12_poF08_X.y_values.values;            % vettore con i valori
C15= C15_tacho.y_values.values;
l2=C15_tacho.x_values.number_of_values;

%% C12_poF08

% max=max(C12);
% min=min(C12);
% mC12=mean(C12);

v=zeros(l1,1); %prealloco
vd=zeros(l1,1);
puntiC12=zeros(l1,1);
% j=1; %indice marcatore
for i=1:l1
    if C12(i)>40
        v(i)=1;            
    end
end

for k=1:(l1-1)
   
        vd(k)=v(k+1)-v(k);            
  
end

for i=1:l1
    if vd(i)==1
        puntiC12(i)=C12(i);
        % marcatore(j)=i;
        % j=j+1;
    end
    
end


%% C15_tacho

mC15=mean(C15);

z=zeros(l2,1); %prealloco
zd=zeros(l2,1);
puntiC15=zeros(l2,1);
confrontatoreC15=ones(l2,1);
for i=1:l2
    if C15(i)<-0,4;
        z(i)=1;            
    end
end

for k=1:(l2-1)

        zd(k)=z(k+1)-z(k);            

end

for i=1:l1
    if zd(i)==1
        puntiC15(i)=C15(i);
    end
end

%% Crosscorrelazione

cross= alignsignals(C12_poF08_X.y_values.values,C15_tacho.y_values.values);
%allineo i segnali in corrispondenza del massimo della cross correlazione
%mi fa vedere il delay fra i due segnali
%plotto il segnale allineato

%% PLOT

figure(1)
plot(C12_poF08_X.y_values.values)
hold on
plot(puntiC12,'o')

figure(2)
plot(C15_tacho.y_values.values  )
hold on
plot(puntiC15,'o')

figure(3)
plot(cross)
%% 