function [doTransmit, r_exit, theta_exit] = pipe_iter(LoverR)
%BLAH Summary of this function goes here
%   Detailed explanation goes here

if nargin==0
    LoverR = 10;
end

RADIUS=1;
LENGTH=LoverR;

% Piper direction is zhat
n = [0; 0; 1];

%% Random Position
r = sqrt(rand);
theta = 2*pi*rand;

Rx = r*cos(theta);
Ry = r*sin(theta);
Rz = 0;

R = [Rx; Ry; Rz];

%% Random Velocity

V = diffuse_velocity(n);

%% First Collision

% Get quadratic equation coefficients
 a = (V(1)^2+V(2)^2);
 b = 2*(R(1)*V(1)+R(2)*V(2));
 c = (R(1)^2+R(2)^2-RADIUS^2);

 % Calculate times (it depends on sign of b)
 tPlus = -b/(2*a)*(1+sqrt(1-4*a*c/b^2));
 tNeg =  -b/(2*a)*(1-sqrt(1-4*a*c/b^2));

 % Get a forward in time solution
 t = max([tPlus tNeg]);

% Update Collision
 R = R+V*t;


 %% Iterate Collisions
iter = 1;
 while R(3)>0 && R(3)<LENGTH 
    % Get normal vector
    n = [-R(1); -R(2);0];
    n = n/norm(n);
    % Get velocity
    V = diffuse_velocity(n);
    
    % Get Quadratic Equation coefficients
    a = (V(1)^2+V(2)^2);
    b = 2*(R(1)*V(1)+R(2)*V(2));

    % Only one non-trivial solution when C=0;
    t=-b/a;

    % Update Collision
    R = R+V*t;
    iter=iter+1;
 end




%% Determine if transmitted

if R(3)>=LENGTH
    doTransmit = true;

    % Step backward along V to z = LENGTH
    R_exit = R + V * ((LENGTH - R(3)) / V(3));
    
    r_exit = norm(R_exit(1:2));
    theta_exit = atan2(norm(V(1:2)), V(3));
else
    doTransmit = false;
    r_exit = NaN;
    theta_exit = NaN;
end

end

