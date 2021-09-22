%% Whole-brain modelling in the homogeneous case

%This model based on Stuard-Landau oscillators, the local dynamics of single brain
%regions using the normal form of a Hopf bifurcation.
%The dynamics of the N brain regions were coupled through the connectivity matrix,
%which was given by the connectome of healthy subjects (C).
%coupling among areas is given by the SC-> by the g scaling parameter.
%For the homogeneous case, in which we seta=0 for all nodes. 
%This choice was based on previous studies which suggest that the best fit
%to the empirical data arises at the brink of the Hopf bifurcation 
%where a~0. So, here the only free parameter is the g.
%The fitting of the model is captures using the correlation of the FC and 
%the Kolmogorov-Smirnov distance of the FCD.


%This version of the model is prepared for individualized subjects (the SC is a template).


%% load data and basic variables

load('SC_original') %Structural connectivity
load('ts_subj_1.mat') %BOLD time-serie

%Basic parameters
Tmax = 276;%Check whats your tmax.
wG =[0.04 0.2 0.5 0.8]%[0:0.01:1];%Range of values of g (depends on the data)
ldata=1;%In this version we run the model only for one subject
C=SC;
C=C/max(max(C))*0.2;%
Cfg.TRsec=1.92;

rng('shuffle');


ap=0.0005;%a values
idxSub=1;%subject
nNodes = length(C);
nSubs = ldata; 
si = 1:ldata; 
nWeights = numel(wG);
subj=1;
%% Details of the model

Cfg.simulID = 'coma1';
Cfg.opt_a.nIters = 200;%Number of iterations for initial optimization
Cfg.opt_a.updateStrength = 0.1;%Update strength for a optimization
Cfg.opt_a.abortCrit = 0.1; %maximally 2.5% error
Cfg.opt_a.gref = 1;%This is reference g, for the initial optimization only. Ignore if not using newOpt

%% Pre-modelling

%In this section, the calculation of the FC, power spectrum, omega and
%other variables that will be used in the model simulation.

fprintf(1, 'Fitting models for %d different weights\n', nWeights);
FC_simul = zeros(nNodes, nNodes, nWeights);
fitting = zeros(1, nWeights);
meta = zeros(1, nWeights);
ksP = zeros(1, nWeights);
Phases = zeros(nNodes, Tmax, nSubs, nWeights);
bifpar = zeros(nWeights, nNodes);

%--------------------------------------------------------------------------
%CALCULATE FUNCTIONAL CONNECTIVITY MATRIX
%--------------------------------------------------------------------------
r = zeros(nNodes, nNodes, nSubs);
ts = zeros(nNodes, Tmax, nSubs);

i=1;
ts(:,:,1) = squeeze(ts_subj_1(subj,:,:));
r(:,:,1) = corrcoef(ts(:,:,1)');

FC_emp=mean(r,3);


%--------------------------------------------------------------------------
%COMPUTE POWER SPECTRA FOR
%NARROWLY FILTERED DATA WITH LOW BANDPASS (0.04 to 0.07 Hz)
%WIDELY FILTERED DATA (0.04 Hz to justBelowNyquistFrequency)
%--------------------------------------------------------------------------
TT=Tmax;
Ts = TT*Cfg.TRsec;
freq = (0:TT/2-1)/Ts;
[~, idxMinFreq] = min(abs(freq-0.04));
[~, idxMaxFreq] = min(abs(freq-0.07));
nFreqs = length(freq);

delt = Cfg.TRsec;                                   % sampling interval (TR)
fnq = 1/(2*delt);                           % Nyquist frequency
k = 2;                                      % 2nd order butterworth filter

%NARROW LOW BANDPASS
flp = .04;                                  % lowpass frequency of filter
fhi = .07;                                  % highpass
Wn=[flp/fnq fhi/fnq];                       % butterworth bandpass non-dimensional frequency
[bfilt_narrow,afilt_narrow] = butter(k,Wn); % construct the filter


PowSpect_filt_narrow = zeros(nFreqs, nNodes, nSubs);
for seed=1:nNodes
        signaldata = squeeze(ts_subj_1(subj,:,:));
        x=detrend(demean(signaldata(seed,:)));
        
        ts_filt_narrow =zscore(filtfilt(bfilt_narrow,afilt_narrow,x));
        pw_filt_narrow = abs(fft(ts_filt_narrow));
        PowSpect_filt_narrow(:,seed,1) = pw_filt_narrow(1:floor(TT/2)).^2/(TT/2);
 end

Power_Areas_filt_narrow_unsmoothed = mean(PowSpect_filt_narrow,3);
Power_Areas_filt_narrow_smoothed = zeros(nFreqs, nNodes);
vsig = zeros(1, nNodes);
for seed=1:nNodes
    Power_Areas_filt_narrow_smoothed(:,seed)=gaussfilt(freq,Power_Areas_filt_narrow_unsmoothed(:,seed)',0.01);
end


[~, idxFreqOfMaxPwr]=max(Power_Areas_filt_narrow_smoothed);
f_diff = freq(idxFreqOfMaxPwr);

%FOR EACH AREA AND TIMEPOINT COMPUTE THE INSTANTANEOUS PHASE IN THE RANGE
%OF .04 TO .09 Hz
PhasesD = zeros(nNodes, Tmax, nSubs);
signaldata=squeeze(ts_subj_1(subj,:,:));
for seed=1:nNodes
    x = demean(detrend(signaldata(seed,:)));
    xFilt = filtfilt(bfilt_narrow,afilt_narrow,x);    % zero phase filter the data
    Xanalytic = hilbert(demean(xFilt));
    PhasesD(seed,:,1) = angle(Xanalytic);
end 


%f_diff  previously computed frequency with maximal power (of narrowly filtered data) by area
omega = repmat(2*pi*f_diff',1,2); %angular velocity
omega(:,1) = -omega(:,1);


%% FROM HERE ON SIMULATIONS AND FITTING

dt = 0.1;
sig = 0.04; 
dsig = sqrt(dt)*sig;

a = repmat(-0.05*ones(nNodes,1),1,2);
a1 = a; %Starting values of a set to ~0
trackminm1 = zeros(Cfg.opt_a.nIters, nWeights); %for tracking the minimization (good for debugging)

for idx_g = 1:nWeights
we = wG(idx_g);

fprintf(1, '-----------------------------------------\n');
fprintf(1, 'g(%d/%d) = %5.3f\n', idx_g, numel(wG), we);
fprintf(1, '-----------------------------------------\n');

xs = zeros(3000/2,nNodes);
wC = we*C; %structural connectivity matrix weighted with current global coupling parameter
sumC = repmat(sum(wC,2),1,2); % for sum Cij*xj 

fprintf(1, 'SIMULATING HOMOGENEOUS MODEL.\n');
a=a1; %use those avalues that have been found to be optimal
bifpar(idx_g,:)=a(:,1)';%store them in an output variable
xs=zeros(Tmax*nSubs,nNodes);

z = 0.1*ones(nNodes,2); % --> x = z(:,1), y = z(:,2)
nn=0;
    for t=1:dt:3000 %This part is to initialize the model and to warm the timeseries
        suma = wC*z - sumC.*z; % sum(Cij*xi) - sum(Cij)*xj
        zz = z(:,end:-1:1); % flipped z, because (x.*x + y.*y)
        z = z + dt*(a.*z + zz.*omega - z.*(z.*z+zz.*zz) + suma) + dsig*randn(nNodes,2);
    end
    
    for t=1:dt:Tmax*Cfg.TRsec*nSubs %check for the specific data
        suma = wC*z - sumC.*z; % sum(Cij*xi) - sum(Cij)*xj
        zz = z(:,end:-1:1); % flipped z, because (x.*x + y.*y)
        z = z + dt*(a.*z + zz.*omega - z.*(z.*z+zz.*zz) + suma) + dsig*randn(nNodes,2);
        
        if mod(t,2)==0
            nn=nn+1;
            xs(nn,:)=z(:,1)';
        end
    end
    
    fprintf(1, 'COMPUTING MODEL FIT.\n');
    FC_simul(:, :, idx_g) = corrcoef(xs(1:nn,:)); 
    cc=corrcoef(squareform(tril(FC_emp,-1)),squareform(tril(FC_simul(:, :, idx_g),-1)));
    fitting(idx_g)=cc(2); %Fitting of the FC
    
    %%%%%%%%%%%%%%%%%%

    tini=(1-1)*Tmax;
    for seed=1:nNodes
        ts_simul = detrend(demean(xs(tini+1:tini+Tmax,seed)'));
        ts_simul_filt_narrow = filtfilt(bfilt_narrow,afilt_narrow,ts_simul);
        Xanalytic = hilbert(ts_simul_filt_narrow);
        Phases(seed,:,1, idx_g) = angle(Xanalytic);
    end

    %% Compute the fitting
    %pcD(:,1)=patternCons30(PhasesD(:,:),nNodes,Tmax); %empirical FCD
    load('pcD_1') %% the FCD has been calculated from the empirical data (following previous line)
    pcS(:,1)=patternCons30(Phases(:,:,1, idx_g),nNodes,Tmax); % simulated FCD 

    [~, ~, ksP(idx_g)]=kstest2(pcS(:),pcD(:));

    fprintf(1, 'DONE.\n\n');
end

figure(1)
plot(wG,ksP,'linewidth',3)
xlabel('Global coupling g')
ylabel('Fitting')
ylim([0 1])
title('Fitting for 4 values of g')

% figure
% imagesc(FC_emp-eye(83))
% xlabel('ROIs')
% ylabel('ROIs')
% title('Empirical FC')
% colorbar
% 
% 
% figure
% imagesc(squeeze(FC_simul(:,:,3))-eye(83))
% xlabel('ROIs')
% ylabel('ROIs')
% title('Simulated FC (g=0.2)')
% colorbar

%% Example for all the range of g from 0 to 1 with a resolution of 0.01

load('ksP')
figure(2)
plot(wG,ksP,'linewidth',3)
xlabel('Global coupling g')
ylabel('Fitting')
ylim([0 1])
title('Fitting for all g values ranging from 0 to 1')



