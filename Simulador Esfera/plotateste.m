%% plota as variaveis salvas no arquivo test.mat
load('test.mat');

%%comando de reset
figure;
subplot(2,2,1);
plot(test_var(1,:),test_var(2,:),'LineWidth',2);
title('comando de reset');
xlabel('tempo [s]');
ylabel('Sinal');
ylim([-0.5,1.5]);
xlim([0,360]);
grid;

%%roll referencia
%figure;
subplot(2,2,2);
plot(test_var(1,:),test_var(6,:),'r--','LineWidth',2); %%referencia
%title('referencia yaw');

%%roll medido pela imu
hold on
plot(test_var(1,:),test_var(3,:),'LineWidth',2); %roll medido pelo sistema
title('roll medido');
grid;
legend('referencia','roll medido')
xlabel('tempo [s]');
ylabel('roll [º]');
xlim([0,360]);
hold off

%%pitch referencia
%figure;
subplot(2,2,3);
plot(test_var(1,:),test_var(7,:),'r--','LineWidth',2); %%referencia
%title('referencia yaw');

%%pitch medido pela imu
hold on
plot(test_var(1,:),test_var(4,:),'LineWidth',2); %pitch medido pelo sistema
title('pitch medido');
grid;
legend('referencia','pitch medido')
xlabel('tempo [s]');
ylabel('pitch [º]');
xlim([0,360]);
hold off

%%yaw referencia
%figure;
subplot(2,2,4);
plot(test_var(1,:),test_var(8,:),'r--','LineWidth',2); %%referencia
%title('referencia yaw');

%%yaw medido pela imu
hold on
plot(test_var(1,:),test_var(5,:),'LineWidth',2); %yaw medido pelo sistema
title('yaw medido');
grid;
legend('referencia','yaw medido')
xlabel('tempo [s]');
ylabel('yaw [º]');
xlim([0,360]);
hold off

%%velocidade do rotor X
figure;
subplot(3,1,1);
%%alvo
plot(test_var(1,:),test_var(9,:)/(2*pi/60)+5000,'r-','LineWidth',2);
hold on
%%medido
plot(test_var(1,:),test_var(12,:)+5000,'b-','LineWidth',2);
hold off
title('velocidade do rotor X');
legend('velocidade do controle','velocidade real');
xlabel('tempo [s]');
ylabel('velocidade do rotor [RPM]');
xlim([0,360]);
grid;

%%velocidade do rotor Y
%figure;
subplot(3,1,2);
%%alvo
plot(test_var(1,:),test_var(10,:)/(2*pi/60)+5000,'r-','LineWidth',2);
hold on
%%medido
plot(test_var(1,:),test_var(13,:)+5000,'b-','LineWidth',2);
hold off
title('velocidade do rotor Y');
legend('velocidade do controle','velocidade real');
xlabel('tempo [s]');
ylabel('velocidade do rotor [RPM]');
xlim([0,360]);
grid;

%%velocidade do rotor Z
%figure;
subplot(3,1,3);
%%alvo
plot(test_var(1,:),test_var(11,:)/(2*pi/60)+5000,'r-','LineWidth',2);
hold on
%%medido
plot(test_var(1,:),test_var(14,:)+5000,'b-','LineWidth',2);
hold off
title('velocidade do rotor Z');
legend('velocidade do controle','velocidade real');
xlabel('tempo [s]');
ylabel('velocidade do rotor [RPM]');
xlim([0,360]);
grid;



%%estimativas de torque
% inicializa variavel torqueRotor e torqueEsfera
torqueRotor = [0;0;0];
velocidadeAngEsfera = [0;0;0];
torqueEsfera = [0;0;0];
i_ultima_aq = 1;

for i=2:length(test_var)
    DeltaTime = test_var(1,i)-test_var(1,i_ultima_aq);
    
    if (DeltaTime>t)
        
        velocidadeAngEsfera(1,i) = (test_var(3,i)-test_var(3,i_ultima_aq))*(pi/180)/DeltaTime;
        velocidadeAngEsfera(2,i) = (test_var(4,i)-test_var(4,i_ultima_aq))*(pi/180)/DeltaTime;
        velocidadeAngEsfera(3,i) = (test_var(5,i)-test_var(5,i_ultima_aq))*(pi/180)/DeltaTime;

        torqueEsfera(1,i) = Ixx*(velocidadeAngEsfera(1,i)-velocidadeAngEsfera(1,i_ultima_aq))/DeltaTime;
        torqueEsfera(2,i) = Iyy*(velocidadeAngEsfera(2,i)-velocidadeAngEsfera(2,i_ultima_aq))/DeltaTime;
        torqueEsfera(3,i) = Izz*(velocidadeAngEsfera(3,i)-velocidadeAngEsfera(3,i_ultima_aq))/DeltaTime;

        torqueRotor(1,i) = I1*(test_var(12,i)-test_var(12,i_ultima_aq))*(pi/60)/DeltaTime;
        torqueRotor(2,i) = I2*(test_var(13,i)-test_var(13,i_ultima_aq))*(pi/60)/DeltaTime;
        torqueRotor(3,i) = I3*(test_var(14,i)-test_var(14,i_ultima_aq))*(pi/60)/DeltaTime;
        
        i_ultima_aq = i;
    else
        velocidadeAngEsfera(1,i) = velocidadeAngEsfera(1,i_ultima_aq);
        velocidadeAngEsfera(2,i) = velocidadeAngEsfera(2,i_ultima_aq);
        velocidadeAngEsfera(3,i) = velocidadeAngEsfera(3,i_ultima_aq);

        torqueEsfera(1,i) = torqueEsfera(1,i_ultima_aq);
        torqueEsfera(2,i) = torqueEsfera(2,i_ultima_aq);
        torqueEsfera(3,i) = torqueEsfera(3,i_ultima_aq);

        torqueRotor(1,i) = torqueRotor(1,i_ultima_aq);
        torqueRotor(2,i) = torqueRotor(2,i_ultima_aq);
        torqueRotor(3,i) = torqueRotor(3,i_ultima_aq);
        
    end
end

figure;
subplot(3,1,1);
plot(test_var(1,:),torqueEsfera(1,:),'r-','LineWidth',2); %%torque esfera no x
hold on
plot(test_var(1,:),torqueRotor(1,:),'b-','LineWidth',2); %%torque rotor no x
title('torque no eixo X');
legend('esfera','rotor');
xlabel('tempo [s]');
ylabel('torque [N.m]');
hold off
grid;
xlim([0,360]);

subplot(3,1,2);
plot(test_var(1,:),torqueEsfera(2,:),'r-','LineWidth',2); %%torque esfera no y
hold on
plot(test_var(1,:),torqueRotor(2,:),'b-','LineWidth',2); %%torque rotor no y
title('torque no eixo Y');
legend('esfera','rotor');
xlabel('tempo [s]');
ylabel('torque [N.m]');
hold off
grid;
xlim([0,360]);

subplot(3,1,3);
plot(test_var(1,:),torqueEsfera(3,:),'r-','LineWidth',2); %%torque esfera no z
hold on
plot(test_var(1,:),torqueRotor(3,:),'b-','LineWidth',2); %%torque rotor no z
title('torque no eixo Z');
legend('esfera','rotor');
xlabel('tempo [s]');
ylabel('torque [N.m]');
hold off
grid;
xlim([0,360]);


figure;
subplot(3,1,1);
plot(test_var(1,:),velocidadeAngEsfera(1,:),'r-','LineWidth',2); %%velocidade da esfera no eixo x
title('velocidade angular X da esfera');
%legend('esfera','rotor');
xlabel('tempo [s]');
ylabel('velocidade angular [rad/s]');
hold off
grid;
xlim([0,360]);

subplot(3,1,2);
plot(test_var(1,:),velocidadeAngEsfera(2,:),'r-','LineWidth',2); %%velocidade da esfera no eixo y
title('velocidade angular Y da esfera');
%legend('esfera','rotor');
xlabel('tempo [s]');
ylabel('velocidade angular [rad/s]');
hold off
grid;
xlim([0,360]);

subplot(3,1,3);
plot(test_var(1,:),velocidadeAngEsfera(3,:),'r-','LineWidth',2); %%velocidade da esfera no eixo z
title('velocidade angular Z da esfera');
%legend('esfera','rotor');
xlabel('tempo [s]');
ylabel('velocidade angular [rad/s]');
hold off
grid;
xlim([0,360]);