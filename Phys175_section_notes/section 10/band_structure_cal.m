%Matthew Rispoli
% Section 10: Band Structure Calculation
% 4/17/2017

clear all
close all
clc

% we will write the potential in terms of recoil energy (just fyi for the
% units of this matrix)

figure(123)
close 123
figure(123)

vs=[0.01, 0.05, 0.1, 0.25, 0.5, 1];
for vv=1:length(vs)
Lmax=5;
G=100;
V=vs(vv);
Dstore=zeros([2*G+1, 2*Lmax+1]);
%make hamiltonian
for kk=1:2*G+1
    H=zeros([2*Lmax+1 2*Lmax+1]);
    for ll=1:2*Lmax+1
        H(ll,ll)=((kk-G)/G + (Lmax+1 - ll))^2;
        if (ll+1)<=2*Lmax+1
            H(ll+1,ll)=V;
            H(ll,ll+1)=V;
        end
    end
    [Ve,De]=eig(H);
    Dstore(kk,:)=diag(De);
end
subplot(1,length(vs),vv)

%plot((-G:G)/G,Dstore(:,1:4))
plot((-G:G)/G,Dstore(:,1:4)-mean(Dstore(:,1)))

axis([-1 1 -2 5])
xlabel('quasimomentum (q/2 \pi)')
ylabel('Energy E_{k,n}')
legend('n=0','n=1','n=2','n=3')
title(sprintf('V/E_r = %0.2f',vs(vv)))
grid on
end
set(gcf,'color','white')



vs=linspace(0.01,8,55);
for vv=1:length(vs)
Lmax=5;
G=100;
V=vs(vv);
Dstore=zeros([2*G+1, 2*Lmax+1]);
%make hamiltonian
for kk=1:2*G+1
    H=zeros([2*Lmax+1 2*Lmax+1]);
    for ll=1:2*Lmax+1
        H(ll,ll)=((kk-G)/G + (Lmax+1 - ll))^2;
        if (ll+1)<=2*Lmax+1
            H(ll+1,ll)=V;
            H(ll,ll+1)=V;
        end
    end
    [Ve,De]=eig(H);
    Dstore(kk,:)=diag(De);
end
BWStore(vv,:)=[(max(Dstore(:,1))-min(Dstore(:,1))), ...
    (max(Dstore(:,2)-min(Dstore(:,2)))), ...
    (max(Dstore(:,3)-min(Dstore(:,3)))), ...
    (max(Dstore(:,4)-min(Dstore(:,4))))];

VLevel(vv,:)=[mean(Dstore(:,1)), ...
    mean(Dstore(:,2)), ...
    mean(Dstore(:,3)), ...
    mean(Dstore(:,4))];

end

%%
figure(244)
close 244
figure(244)
plot([vs; vs; vs; vs;]', BWStore)
grid on
set(gcf,'color','white')
xlabel('Potential Depth (V/E_r)')
ylabel('Band Width (E_r)')
title('Band Width Scaling')
legend('n=0','n=1','n=2','n=3')




figure(255)
close 255
figure(255)
plot(sqrt([vs; vs; vs;]'), VLevel(:,2:4)-VLevel(:,1:3))
grid on
set(gcf,'color','white')
xlabel('Root Potential Depth (V^{1/2})')
ylabel('Average Band Energy')
title('Scaling of Band Energy with Potential Depth')
%%




% differing number of L's
%{






figure(234)
close 234
figure(234)
vs=[1,2,3,4,5,10];
for vv=1:length(vs)
Lmax=vs(vv);
G=100;
V=0.5;
Dstore=zeros([2*G+1, 2*Lmax+1]);
%make hamiltonian
NG=1;
for kk=1:(NG*2)*G+1
    H=zeros([2*Lmax+1 2*Lmax+1]);
    for ll=1:2*Lmax+1
        H(ll,ll)=((kk-NG.*G)/G + (Lmax+1 - ll))^2;
        if (ll+1)<=2*Lmax+1
            H(ll+1,ll)=V;
            H(ll,ll+1)=V;
        end
    end
    [Ve,De]=eig(H);
    Dstore(kk,:)=diag(De);
end
subplot(1,length(vs),vv)
plot((-NG.*G:NG.*G)/G,Dstore(:,:))
axis([-NG NG -2 5])
xlabel('quasimomentum (q/\pi)')
ylabel('Energy E_{k,n}')
legend('n=0','n=1','n=2','n=3')
title(sprintf('V/E_r = 0.5, Lmax=%i',vs(vv)))
grid on
end
set(gcf,'color','white')



%}


%why they matter!




figure(234)
close 234
figure(234)
vs=[1,2,3,4,5,10];
for vv=1:length(vs)
Lmax=vs(vv);
G=100;
V=0.5;
Dstore=zeros([2*G+1, 2*Lmax+1]);
%make hamiltonian
NG=4;
for kk=1:(NG*2)*G+1
    H=zeros([2*Lmax+1 2*Lmax+1]);
    for ll=1:2*Lmax+1
        H(ll,ll)=((kk-NG.*G)/G + (Lmax+1 - ll))^2;
        if (ll+1)<=2*Lmax+1
            H(ll+1,ll)=V;
            H(ll,ll+1)=V;
        end
    end
    [Ve,De]=eig(H);
    Dstore(kk,:)=diag(De);
end
subplot(1,length(vs),vv)
plot((-NG.*G:NG.*G)/G,Dstore(:,:))
axis([-NG NG -2 5])
xlabel('quasimomentum (q/ 2 \pi)')
ylabel('Energy E_{k,n}')
legend('n=0','n=1','n=2','n=3')
title(sprintf('V/E_r = 0.5, Lmax=%i',vs(vv)))
grid on
end
set(gcf,'color','white')


