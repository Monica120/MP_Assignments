function [speedArray] = SpeedAdjust(thetaFinal, thetaC)


[maxTDiff, maxDiffI] = max(abs(thetaFinal - thetaC));
%percentComp = (thetaFinal - thetaC)./thetaFinal;
speedArray = [0.2, 0.2, 0.2];
maxSpeed = 0.4;
minSpeed = 0.2;
diff = abs(thetaFinal - thetaC);
adjustSpeed = (diff/maxTDiff)*maxSpeed;
n = size(speedArray);
for i = 1:3
    if adjustSpeed(i) > minSpeed
        speedArray(i) = adjustSpeed(i);
    end
end







end