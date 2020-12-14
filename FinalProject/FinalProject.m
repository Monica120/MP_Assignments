%Final Project

a = arduino('COM6','Mega2560','Libraries','Adafruit\MotorShieldV2')
shield1 = addon(a,'Adafruit\MotorShieldV2')
shield2 = addon(a, 'Adafruit\MotorshieldV2','I2CAddress', '0x61')
addrs = scanI2CBus(a,0)

%Motor setup
M1 = dcmotor(shield1,1);
M2 = dcmotor(shield1,2);
M3 = dcmotor(shield1,3);
M4 = dcmotor(shield1,4);
M5 = dcmotor(shield2,1);

M1.Speed = 0.2;%setup speed
M2.Speed = 0.2;
M3.Speed = 0.2;
M4.Speed = 0.2;
M5.Speed = 0.2;

%start(M1);
%M1.Speed = -0.2;%R
%pause(.5);
%stop(M1);

%Get Potentiometer Values
M1P = readVoltage(a, 'A10');
M2P = readVoltage(a, 'A11');
M3P = readVoltage(a, 'A12');
M4P = readVoltage(a, 'A13');
M5P = readVoltage(a, 'A14');

%Convert
M1Degree = 360*(M1P/5);
M2Degree = 360*(M2P/5);
M3Degree = 360*(M3P/5);
M4Degree = 360*(M4P/5);
M5Degree = 360*(M5P/5);

%Get to default position
start(M1);
while (M1Degree < 165 || M1Degree > 185)
    if (M1Degree < 165 )
        M1.Speed = -0.2;%R
    else
        M1.Speed = 0.2;%R
    end
    M1P = readVoltage(a, 'A10');
    M1Degree = 360*(M1P/5);
end
stop(M1);
start(M2);
while (M2Degree < 190 || M2Degree > 210)
    if (M2Degree < 190)
        M2.Speed = -0.2;%R
    else
        M2.Speed = 0.2;%R
    end
    M2P = readVoltage(a, 'A11');
    M2Degree = 360*(M2P/5);
end
stop(M2);
start(M3);
while (M3Degree < 50 || M3Degree > 70)
    if (M3Degree < 50)
        M3.Speed = 0.2;%R
    else
        M3.Speed = -0.2;%R
    end
    M3P = readVoltage(a, 'A12');
    M3Degree = 360*(M3P/5);
end
stop(M3);


%Specify Points
%tips = [14,2,0; 14,2,3; 22, 0,0; 22,0,3;...
%    22,-5,0; 22,-5,3; 14,-5,0; 14,-5,3; 14,2,0];%xyz points in cm
%tips = [14,2,0; 22, 0,0; 22,-5,0; 14,-5,0; 14,2,0];

tips = [25,10,5; 25,10,-3; 15,-10,-3;  15,-10,5; 15,10,5; 15,10,-3;...
    25,-10,-3; 25,-10,5];
%tips = [12,2,-3; 12,10,-3; 12,10,7];
    %12,2,4; 20,0,4; 20,0,-3]
%Calculate degrees
Angles = AngleCalculate(tips);

%Move to specified angles
j = size(tips);
for i = 1:j(1)
    start(M1);
    start(M2);
    start(M3);
    while (M1Degree < (Angles(i,1)-10) || M1Degree > (Angles(i,1)+10)...
            || M2Degree < (Angles(i,2)-10) || M2Degree > (Angles(i,2)+10)...
            || M3Degree < (Angles(i,3)-10) || M3Degree > (Angles(i,3)+10))
        %Motor1
        if (M1Degree < (Angles(i,1)-10) )
            M1.Speed = -0.2;
        elseif(M1Degree > (Angles(i,1)+10))
            M1.Speed = 0.2;
        else
            stop(M1);
        end
        M1P = readVoltage(a, 'A10');
        M1Degree = 360*(M1P/5);
        
        %Motor2
        if (M2Degree < (Angles(i,2)-10))
            M2.Speed = -0.2;
        elseif M2Degree > (Angles(i,2)+10)
            M2.Speed = 0.2;
        else
            stop(M2);
        end
        M2P = readVoltage(a, 'A11');
        M2Degree = 360*(M2P/5);
        %Motor3
        
        if (M3Degree < (Angles(i,3)-10))
            M3.Speed = 0.2;
        elseif M3Degree > (Angles(i,3)+10)
            M3.Speed = -0.2;
        else
            stop(M3);
        end
        M3P = readVoltage(a, 'A12');
        M3Degree = 360*(M3P/5);  
    end
    
end
stop(M1);
stop(M2);
stop(M3);




start(M1);
start(M2);
start(M3);


%Get back to default position
while ((M1Degree < 165 || M1Degree > 185)...
        || (M2Degree < 190 || M2Degree > 210)...
        || (M3Degree < 50 || M3Degree > 70))
    %Motor1
    if (M1Degree < 165 )
        M1.Speed = -0.2;
    elseif(M1Degree > 185)
        M1.Speed = 0.2;
    else
        stop(M1);
    end
    M1P = readVoltage(a, 'A10');
    M1Degree = 360*(M1P/5);

    %Motor2
    if (M2Degree < 190)
        M2.Speed = -0.2;
    elseif M2Degree > 210
        M2.Speed = 0.2;
    else
        stop(M2);
    end
    M2P = readVoltage(a, 'A11');
    M2Degree = 360*(M2P/5);
    %Motor3

    if (M3Degree < 50)
        M3.Speed = 0.2;
    elseif M3Degree > 70
        M3.Speed = -0.2;
    else
        stop(M3);
    end
    M3P = readVoltage(a, 'A12');
    M3Degree = 360*(M3P/5);  
end
stop(M1);
stop(M2);
stop(M3);






clear s M1 M2 M3 M4 M5 sm shield1 shield2 a
