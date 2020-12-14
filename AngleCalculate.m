%Calculate degrees using inverse kinematics
%make function and traverse matrix
function [Angles] = AngleCalculate(tips)
R1 = 10;%link lengths
R2 = 19;
Angles = tips;
%Calculate degrees
n = size(tips);
for c = 1:n(1)
    Theta1 = atan2(tips(c,2), tips(c,1));
    P1 = -((tips(c,1).^2)+ (tips(c,3).^2));%splitting large equation
    P2 = (R1.^2) + (R2.^2);
    P3 = 2*R1*R2;
    Theta2 = acos((P1+P2)/P3) - (pi/2);
    P4 = -(R2.^2) + (R1.^2) + (tips(c,1).^2)+(tips(c,3).^2);
    P5 =  2*R1*sqrt((tips(c,1).^2)+(tips(c,3).^2));
    Theta3 = atan2(tips(c,3),(tips(c,1))) + acos(P4/P5);
    Test = atan2(12, 5);

    %convert to degrees
    T1D = (Theta1/(2*pi))*360;
    T2D = (Theta2/(2*pi))*360;
    T3D = (Theta3/(2*pi))*360;
    
    %Angle Adjustment
    T1 = 170 + T1D;
    T2 = 200 + T2D;%Backwards
    T3 = 60 + T3D - 100;
    
    Angles(c, 1) = T1;
    Angles(c, 2) = T2;
    Angles(c, 3) = T3;
end

end

