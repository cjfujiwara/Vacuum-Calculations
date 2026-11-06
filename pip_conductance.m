function [T, sigmaT, Nattempt, Ntransmit,rAll,thetaAll] = pip_conductance(L)

targetRelErr = 0.001;
targetTransmits = ceil(1/targetRelErr^2);

batchSize = 5000;
maxAttempts = 2e7;

Nattempt = 0;
Ntransmit = 0;

rAll=[];
thetaAll=[];

while Ntransmit < targetTransmits && Nattempt < maxAttempts
    transmitBatch = false(batchSize,1);
    %rBatch = zeros(batchSize,1);
    %thetaBatch = zeros(batchSize,1);

    parfor i = 1:batchSize
        % [transmitBatch(i),rBatch(i),thetaBatch(i)] = pipe_iter(L);
                [transmitBatch(i),~,~] = pipe_iter(L);

    end

    Ntransmit = Ntransmit + sum(transmitBatch);
    Nattempt = Nattempt + batchSize;

    % inds = ~isnan(rBatch);
    %rAll=[rAll; rBatch(inds)];
    %thetaAll=[thetaAll; thetaBatch(inds)];
end

T = Ntransmit/Nattempt;
sigmaT = sqrt(T*(1-T)/Nattempt);

end

