%% SCRIPT FOR THE EXERCISE 1 OF THE TUTORIAL:

%This script provides you the exercises for understanding a hopf
%oscillator.

clear all
clc
close all


%%  1- basic parameters; 
%Define the basic parameters to simulate the different regimes of the oscillator. 

%Here, we will consider only one node 
nNodes=1;

%The omega, the intrinsic frequency of the node or angular velocity, is
%fixed as 0.5.
omega_val=0.5;
omega = repmat(omega_val*ones(nNodes,1)',1,2); 
omega(:,1) = -omega(:,1);

%Connectivity between oscillators (in this case connectivity 0)
wC=zeros(1,1);
sumC=[0,0];

%bifurcation parameters. The bifurcation parameter will set the oscillation
%regime of the oscillator. Depending on this value, the oscillations that
%the oscillator will show is different. 
%For a>0, the oscillator shows sustained oscillations
%For a>0, stable noisy oscillations
%For a~0, phase transition
%This parameter will be changes during the exercize.
a=0;


%% basic parameters of the model
xs=zeros(200,nNodes);
z = 0.1*ones(nNodes,2); % --> x = z(:,1), y = z(:,2)
dt = 0.1;
sig = 0.04; 
dsig = 0.01; 
nn=0;

%% model training
for t=1:dt:5000 %Simulate the oscillation for 500 time points
    %Here based on the equations, we simulate the dynamics.
    suma = wC*z- sumC.*z; % sum(Cij*xi) - sum(Cij)*xj
    zz = z(:,end:-1:1); % flipped z, because (x.*x + y.*y)
    z = z + dt*(a.*z + zz.*omega - z.*(z.*z+zz.*zz) + suma) + dsig*randn(nNodes,2);
    nn=nn+1;
    xs(nn,:)=z(:,1)';
end

figure(1)
plot(demean(xs(1:5000))) %Plot small range for understand it easier
xlim([0 800])
title(sprintf('a=%d  w = %02f',a,omega_val))
xlabel('Time')
ylabel('Signal')

