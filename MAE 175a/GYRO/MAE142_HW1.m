% X = (Re + h)*cosd(phi)*cosd(lam)
% Y = (Re + h)*cosd(phi)*sind(lam)
% Z = (Re + h)*sind(lam)
% phi latitude 
% lamba longitude
%% Q1
po = 32.69999999;
lo = -117.2;
Te2l = [-sind(po)*cosd(lo) -sind(po)*sind(lo) cosd(po); ...
        -sind(lo)          cosd(lo)         0 ;...
        -cosd(po)*cosd(lo) -cosd(po)*sind(lo) -sind(po)]
R_ECEF = [0;0;8000];
R_NED = Te2l*R_ECEF;

%% Q3
Re = 6367;

Xo = -1242159
Yo = -4743915
Zo =  4067275
Uo = [Xo; Yo; Zo]

% Denver
phi = 39.849312
lam = -104.673828
h=0 
X = (Re + h)*cosd(phi)*cosd(lam)
Y = (Re + h)*cosd(phi)*sind(lam)
Z = (Re + h)*sind(lam)
distance_DENVER = norm(Uo - [X; Y; Z])

% LAX
phi = 33.942791
lam = -118.410042
h=0 
X = (Re + h)*cosd(phi)*cosd(lam)
Y = (Re + h)*cosd(phi)*sind(lam)
Z = (Re + h)*sind(lam)
distance_LAX = norm(Uo - [X; Y; Z])

% Washinton
phi = 38.9348
lam = -77.44728
h=0 
X = (Re + h)*cosd(phi)*cosd(lam)
Y = (Re + h)*cosd(phi)*sind(lam)
Z = (Re + h)*sind(lam)
distance_IAD = norm(Uo - [X; Y; Z])

% SAN Diego
phi = 32.732356
lam = -117.196053
h=0 
X = (Re + h)*cosd(phi)*cosd(lam)
Y = (Re + h)*cosd(phi)*sind(lam)
Z = (Re + h)*sind(lam)
distance_SAN = norm(Uo - [X; Y; Z])


