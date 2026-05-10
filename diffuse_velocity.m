function Vout = diffuse_velocity(n)



%% RANDOM VELOCITY in Z DIRECTION
% theta is polar angle; phi is azimuthal angle
u1 = rand;  % seed for azimuthal angle;
u2 = rand;  % seed for polar angle.

% Diffuse cosine emmisione p(Omega)=cos(theta)
% p(Omega) dOmega =  cos(theta)*sin(theta)*dTheta*dPhi
%   u = cos(theta)
%   du = -sin(theta) dTheta
%   p(u) du = u du (Up to a sign)
% normalize p(u) on [0,1] (theta=[0,pi/2])
% ==> p(u) = 2u
% ==> cdf(u) = u^2
phi = 2*pi*u1;

cosTheta = sqrt(u2);  
sinTheta = sqrt(1-u2);

Vx = sinTheta*cos(phi);
Vy = sinTheta*sin(phi);
Vz = cosTheta;

V = [Vx;Vy;Vz];


%% Rotate Vector
% n : surface normal vector 3x1
% t1 : surface tangent vector 3x1;
% t2 : surface tangent vector 3x1;

if nargin == 0 
    n = [0; 0; 1];
end

% Normalize vector
n = n/norm(n);

% Construct tangent directions
if abs(n(3))< 0.9
    a = [0; 0; 1];
else
    a = [1; 0; 0];
end

% Create a vector normal to n and random (non-parallel)
t1 = cross(a,n);
t1 = t1 /norm(t1);

% Create a vector normal to n and t1;
t2 = cross(n,t1);


% Rotation matrix to refine z to n
R  = [t1 t2 n];

%%

Vout = R*V;


end



