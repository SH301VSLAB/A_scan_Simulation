function [ang_in, ang_out]=snells_law(ang, c1, c2, type)
% [ang_in, ang_out]=snells_law(ang, c1, c2, type)returns (ang_in, ang_out)
% the incident and refracted angle at a plane interface, respectively,
% (in degrees)that satisfy Snell’s law. The first input, ang, is a given 
% incident or refracted angle, ang, (in degrees) that a travelling wave
% makes with respect to the normal of a plane interface. The wave speed in
% the first medium is c1 and the wave speed in the second medium is c2. The
% input parameter, type, is either the string 'f' or the string 'r', 
% indicating a forward or reverse, problem, respectively. For a forward 
% problem ang is taken as the incident angle and the refracted angle is 
% calculated. For a reverse problem ang is taken to be the refracted angle
% and the incident angle is calculated. The angle argument, ang, must be
% in the range 0 <= ang <= 90 degrees.
%
% If the refracted angle is beyond a critical angle, a message indicating
% that fact is returned and ang_out is set to 90 degrees.
%
% If there is no real incident angle corresponding to a given refracted
% angle an error message is returned.

if ang <0 || ang > 90
    error( ' specified angle must be between 0 and 90 degrees')
end

if strcmp(type, 'r')
    ang_out = ang;
    if (c1.*sind(ang_out)./c2) <= 1
        ang_in =asind(c1.*sind(ang_out)./c2); 
    else
        error( ' no real input angle for the given refracted angle')
    end
elseif strcmp(type, 'f')
    ang_in = ang;
    if (c2.*sind(ang_in)./c1) <= 1
    ang_out =asind(c2.*sind(ang_in)./c1);
    else
        disp( 'refracted angle is beyond critical,setting ang_out =90')
        ang_out = 90;
    end
else
    error('the input string must be ''f'' or ''r''')
end