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

% start(M2);
% M2.Speed = 0.2;%R
% pause(1);
% stop(M2);

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
%r=5;
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


%Get Potentiometer Values
M1P = readVoltage(a, 'A10');
M2P = readVoltage(a, 'A11');
M3P = readVoltage(a, 'A12');

%Convert
M1Degree = 360*(M1P/5);
M2Degree = 360*(M2P/5);
M3Degree = 360*(M3P/5);

%Specify Points
%tips = [14, 0, 4.1;14, 0, 4.1; 14,0,7];
tips = GenerateSnowflake(14, 0, 5.5, 8, 10);%Snowflake Pattern
%tips = [17,0,6; 14,0,6; 14,5,6; 17,5,10;17,0,6];

%If point distance > 29 then out of range
%Calculate degrees
Angles = AngleCalculateCont(tips);

M1FirstStart = 0;%Start motor only when needed
M2FirstStart = 0;
M3FirstStart = 0;
currentAngles = [0,0,0];
speeds = [0,0,0];
t = 8;%tolerance
firstRun  = 0;
%Move to specified angles
j = size(tips);
 for i = 1:j(1)
%     M1P = readVoltage(a, 'A10');
%     M1Degree = 360*(M1P/5);
%     M2P = readVoltage(a, 'A11');
%     M2Degree = 360*(M2P/5);
%     M3P = readVoltage(a, 'A12');
%     M3Degree = 360*(M3P/5);
%     currentAngles(1)= M1Degree;
%     currentAngles(2)= M2Degree;
%     currentAngles(3)= M3Degree;
%     speeds = SpeedAdjust(tips(i), currentAngles);

    while (M1Degree < (Angles(i,1)-t) || M1Degree > (Angles(i,1)+t)...
            || M2Degree < (Angles(i,2)-t) || M2Degree > (Angles(i,2)+t)...
            || M3Degree < (Angles(i,3)-t) || M3Degree > (Angles(i,3)+t))
                
          
        %Motor1
        if (M1Degree < (Angles(i,1)-t))
            if(M1FirstStart == 0)
                start(M1);
                M1FirstStart = M1FirstStart+1;
            end
            M1.Speed = -0.2;%-0.2;
        elseif(M1Degree > (Angles(i,1)+t))
            if(M1FirstStart == 0)
                start(M1);
                M1FirstStart = M1FirstStart+1;
            end
            M1.Speed = 0.2;%0.2;
        else
            stop(M1);
        end
        M1P = readVoltage(a, 'A10');
        M1Degree = 360*(M1P/5);
        
        %Motor2
        if (M2Degree < (Angles(i,2)-t))
            if(M2FirstStart == 0)
                start(M2);
                M2FirstStart = M2FirstStart+1;
            end
            M2.Speed = -0.2;%-0.2;%
        elseif (M2Degree > (Angles(i,2)+t))
            if(M2FirstStart == 0)
                start(M2);
                M2FirstStart = M2FirstStart+1;
            end
            M2.Speed = 0.2;%0.2;
        else
            stop(M2);
        end
        M2P = readVoltage(a, 'A11');
        M2Degree = 360*(M2P/5);
        
        %Motor3
        if (M3Degree < (Angles(i,3)-t))
            if(M3FirstStart == 0)
                start(M3);
                M3FirstStart = M3FirstStart+1;
            end
            M3.Speed = 0.3;%speeds(3)
        elseif (M3Degree > (Angles(i,3)+t))
            if(M3FirstStart == 0)
                start(M3);
                M3FirstStart = M3FirstStart+1;
            end
            M3.Speed = -0.3;%speeds(3)
        else
            stop(M3);
        end
        M3P = readVoltage(a, 'A12');
        M3Degree = 360*(M3P/5);  
        
        
    end
    
    
    
    stop(M1);%Stop last motor to complete
    stop(M2);
    stop(M3);
    M1FirstStart = 0;
    M2FirstStart = 0;
    M3FirstStart = 0;
    
end
stop(M1);
stop(M2);
stop(M3);

%pause(10);


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
        M3.Speed = 0.25;
    elseif M3Degree > 70
        M3.Speed = -0.25;
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
