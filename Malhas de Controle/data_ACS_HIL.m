%% Program to calculate de data for IMA
t = 0.5; %0.5

%% Definicoes da inercia da esfera
I = [ 0.135845202 -0.000022908  -0.000174394;
     -0.000022908  0.135910014   0.000229520;
     -0.000174394  0.000229520   0.122729410; ];

Ixx = I( 1, 1 );
Iyy = I( 2, 2 );
Izz = I( 3, 3 );

%% Definicoes de inercia para rodas de reação
I1 = 0.000624567;
I2 = 0.000624567;
I3 = 0.000624567;

%% Espaco de estado para modelagem eletrica e mecanica do motor
R1 = 0.89;
R2 = R1;
R3 = R2;
L1 = 60e-6;
L2 = L1;
L3 = L2;
B1 = (5.2e-4)*(10^-3)*(60/(2*pi));
B2 = B1;
B3 = B1;
J1 = I1 + 3e-06;
J2 = I2 + 3e-06;
J3 = I3 + 3e-06;
Kt = 21e-3;
Ke = (2.199e-3)*(60/(2*pi));

%% Definicoes dos ganhos para controlador dos motores
Kp_x = 0.2;
Kp_y = Kp_x;
Kp_z = Kp_x;

Ki_x = 1;
Ki_y = Ki_x;
Ki_z = Ki_x;

%% Definicoes dos ganhos de controle para esfera
Ts = 40;
qsi = 1;
wn = 4/Ts;

in1 = [ 10 10 25 30 0 ] * pi / 180;
in2 = [ 0 10 10 30 0 ] * pi / 180;
in3 = [ 45 -30 30 30 0 ] * pi / 180;

vp = 11;
vr = 8;

Kpx = vp * (wn^2) * Ixx;
Kpy = vp * (wn^2) * Iyy;
Kpz = vp * (wn^2) * Izz;

Krx = vr * 2 * Ixx * wn * qsi;
Kry = vr * 2 * Iyy * wn * qsi;
Krz = vr * 2 * Izz * wn * qsi;

%% Modelo Roda Eixo X
Arwx = [-B1/J1 Kt/J1;
        -Ke/L1 -R1/L1];

Brwx = [0;
        1/L1];
 
Crwx = [1 0;
        0 1;
        -B1/J1 Kt/J1];
    
Drwx = zeros(3,1);

%% Modelo Roda Eixo Y
Arwy = [-B2/J2 Kt/J2;
        -Ke/L2 -R2/L2];

Brwy = [0;
        1/L2];
 
Crwy = [1 0;
        0 1;
        -B2/J2 Kt/J2];
    
Drwy = zeros(3,1);

%% Modelo Roda eixo Z
Arwz = [-B3/J3 Kt/J3;
        -Ke/L3 -R3/L3];

Brwz = [0;
        1/L3];
 
Crwz = [1 0;
        0 1;
        -B3/J3 Kt/J3];
    
Drwz = zeros(3,1);

%% Velocidades Iniciais das rodas
mW0 = 0000 / ( 60 / ( 2*pi ) ); %%%original 1000 rpm
Wx0 = [mW0 0];
Wy0 = [mW0 0];
Wz0 = [mW0 0];
