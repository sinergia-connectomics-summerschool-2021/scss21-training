%% EXERCISE 2: In this exercise, the goal is to couple two oscillators to 
%% study the effect of the global coupling g.

% The global coupling g fixes the interactions and coupling between the
% oscillators.

%% Define the network
%The network will consist on 10 nodes and the first node will be the only node
%connected with the rest of the nodes (one hub).
nNodes=10;
C=zeros(nNodes,nNodes);
for n=1:nNodes
C(n,n)=1;
end
for n=1:3
C(n,1:3)=1;
end
C(4,:)=1;
C(:,4)=1;
for n=5:10
C(n,5:10)=1;
end
C=C/max(max(C))*0.2;

figure
imagesc(C)
xlabel('Node')
ylabel('Node')
title('SC')
colormap('summer')
%% First case: without global coupling (g=0) and all the nodes working in the same ragime.

%basic parameters; omega/G/a
omega = repmat(2*pi*0.5*ones(nNodes,1),1,2); %angular velocity
omega(:,1) = -omega(:,1);
%values of a
a_val=0;
a = repmat(a_val*ones(nNodes,1),1,2);
%value of the hub
a(4,1)=1;
a(4,2)=1;
G=0.2;

%% basic parameters of the model
xs=zeros(500,nNodes);
z1=repmat(randn(nNodes,1),1,2);
z = 0.1*randn(nNodes,2);%*ones(nNodes,2); % --> x = z(:,1), y = z(:,2)
dt = 0.01;
sig = 0.04; %was 0.04
dsig = 0.01; % to avoid sqrt(dt) at each time step
nn=0;
wC = G*C;
sumC = repmat(sum(wC,2),1,2);

%% model training
for t=1:dt:100 
    suma = wC*z- sumC.*z; % sum(Cij*xi) - sum(Cij)*xj
    zz = z(:,end:-1:1); % flipped z, because (x.*x + y.*y)
    z = z + dt*(a.*z + zz.*omega - z.*(z.*z+zz.*zz) + suma) + dsig*randn(nNodes,2);
     nn=nn+1;
    xs(nn,:)=z(:,1)';
end

%%Ploting
figure(5)
plot(demean(xs(3000:4500,:)))
hold on
plot(demean(mean(xs(3000:4500,:),2)),'r','Linewidth',3)
legend('Node 1','Node 2','Node 3','Node 4','Node 5','Node 6','Node 7','Node 8','Node 9','Node 10','Mean Signal')
title('g=0.2 a=0 a_{node}=1 w=2*\pi*0.5')
xlabel('Time')
ylabel('Signal')

figure(6)
imagesc(corrcoef(xs))
xlabel('Node')
ylabel('Node')
title('FC (g=0.2)')
colorbar
colormap('jet')

%% Second case: with global coupling (g=0.5), i.e. the nodes are coupled 
%% and interacting between them. To study the difference that the coupling
%% can exert over the whole network, all the nodes will be working in the
%% same ragime (a=0) and the hub will work in the oscillatory regime (a=1).
%Study the changes in the mean value of the signals when comparing first
%and second cases.




