function [T, sigmaT, Nattempt, Ntransmit] = pip_conductance(L)

targetRelErr = 0.001;
targetTransmits = ceil(1/targetRelErr^2);

batchSize = 5000;
maxAttempts = 2e7;

Nattempt = 0;
Ntransmit = 0;


while Ntransmit < targetTransmits && Nattempt < maxAttempts
    transmitBatch = false(batchSize,1);

    parfor i = 1:batchSize
        [transmitBatch(i),~,~] = pipe_iter(L);
    end

    Ntransmit = Ntransmit + sum(transmitBatch);
    Nattempt = Nattempt + batchSize;
end

T = Ntransmit/Nattempt;
sigmaT = sqrt(T*(1-T)/Nattempt);

end

