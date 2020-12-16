%Generate Snowflake
function [Stips] = GenerateSnowflake(X4, Y1, Z1, Z2, L)
%Start Values
%X4 = 10;
%Y1 = 0;
%L = 10;

X2 = 0.5*L*sin(pi/6);
Y2 = 0.5*L*cos(pi/6);
 

%Tips Array
Stips = zeros(12,3);

Stips(1,:) = [X4+L, Y1, Z2];%Hover over
Stips(2,:) = [X4+L, Y1, Z1];
Stips(3,:) = [X4, Y1, Z1];
Stips(4,:) = [X4, Y1, Z2];%Lift

Stips(5,:) = [0.5*L+X2+X4, -Y2, Z2];
Stips(6,:) = [0.5*L+X2+X4, -Y2, Z1];
Stips(7,:) = [0.5*L-X2+X4, Y2, Z1];
Stips(8,:) = [0.5*L-X2+X4, Y2, Z2];

Stips(9,:) = [0.5*L+X2+X4, Y2, Z2];
Stips(10,:) = [0.5*L+X2+X4, Y2, Z1];
Stips(11,:) = [0.5*L-X2+X4, -Y2, Z1];
Stips(12,:) = [0.5*L-X2+X4, -Y2, Z2];


end




