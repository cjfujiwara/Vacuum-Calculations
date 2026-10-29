Npipes = 100;
L = linspace(0,100,Npipes)';
L(1)=.001;

T=L;
sigmaT=L;
Nattempt=L;
Ntransmit=L;

for ii=1:Npipes
    disp(ii);
    [T(ii), sigmaT(ii), Nattempt(ii), Ntransmit(ii)] = pip_conductance(L(ii));
end

%%
hf =figure(1);
clf
plot(L,T,'linewidth',1);
hold on

plot(L,4/3*(2./L),'r-','linewidth',1)

legend({'monte carlo','theoretical limit'})

xlabel('L/R');
ylabel('tranmission probability')

set(gca,'YScale','log')
title('Monte Carlo Conductance of Tube')
set(gca,'FontSize',14)
set(gcf,'color','w')

%% Save as an h5 file

%{
tic
L=L(:);
T=T(:);

sigmaT=sigmaT(:);
Nattempt=Nattempt(:);
Ntransmit=Ntransmit(:);

myname = 'round_pipe.h5';

if isfile(myname)
    delete(myname);
end

h5create(myname, "/metadata/description", 1, "Datatype", "string");
h5write(myname, "/metadata/description", ...
    "Transmittance calculations for round pipe.");

h5create(myname, "/L", size(L));
h5write(myname,"/L",L);
h5writeatt(myname,"/L","units","R");
h5writeatt(myname,"/L","description","Pipe length in units of pipe radius.");


h5create(myname, "/T", size(T));
h5write(myname, "/T", T);
h5writeatt(myname,"/T","units","probability");
h5writeatt(myname,"/T","description","transmittance probability");

h5create(myname, "/sigmaT", size(sigmaT));
h5write(myname, "/sigmaT", sigmaT);
h5writeatt(myname,"/sigmaT","units","probability");
h5writeatt(myname,"/sigmaT","description","binomial error");


h5create(myname, "/Nattempt", size(Nattempt));
h5write(myname, "/Nattempt", Nattempt);
h5writeatt(myname,"/Nattempt","units","counts");
h5writeatt(myname,"/Nattempt","description","Number of attempts.");

h5create(myname, "/Ntransmit", size(Ntransmit));
h5write(myname, "/Ntransmit", Ntransmit);
h5writeatt(myname,"/Ntransmit","units","counts");
h5writeatt(myname,"/Ntransmit","description","Number of tranmission events.");

h5disp(myname);

toc
%}