%Calculate degrees using inverse kinematics
%make function and traverse matrix
function [Angles] = AngleCalculateCont(tips)
R1 = 10;%link lengths
R2 = 19;
Angles = tips;
%Calculate degrees
n = size(tips);
for c = 1:n(1)
    Theta1 = atan2(tips(c,2), tips(c,1));
    %law of cosines
    P4 = -(R2.^2) + (R1.^2) + (tips(c,1).^2)+(tips(c,3).^2)+(tips(c,2).^2); %-R1^2+R2^2+x^2+z^2+y^2
    P5 =  2*R1*sqrt((tips(c,1).^2)+(tips(c,3).^2)+(tips(c,3).^2));%2R1*sqrt(x^2+z^2+y^2)
    Theta2 = atan2(tips(c,3) , sqrt((tips(c,1).^2) + (tips(c,2).^2))) + acos(P4/P5);
    
    P1 = -((tips(c,1).^2)+ (tips(c,3).^2)+(tips(c,2).^2));%-(x^2+y^2+z^2)
    P2 = (R1.^2) + (R2.^2);
    P3 = 2*R1*R2;
    Theta3 = acos((P1+P2)/P3) - (pi/2);
    
    %Test = atan2(12, 5);

    %convert to degrees
    T1D = (Theta1/(2*pi))*360;
    T2D = (Theta2/(2*pi))*360;
    T3D = (Theta3/(2*pi))*360;
    
    %Potentiometer Calibrate
    T1P = (T1D/90)*115;%285--90 170-0
    T2P = (T2D/90)*114;%190-90 76-0
    T3P = (T3D/90)*133;%200-90 67-0
    
    %Angle Adjustment
    T1 = 170 + T1P;
    T2 = 70 + T2P;%76 is potentiometer Theta2 = 0 %old76 + T2D
    T3 = 65 + T3P;%old 65
    
    Angles(c, 1) = T1;
    Angles(c, 2) = T2;
    Angles(c, 3) = T3;
end

end

