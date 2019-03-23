
% Simulation of a boost converter with limit cycle

function run_BoostConverter

global L C R E;
C=0.5;L=1;R=2;E=1;

TSPAN=[0 10];
JSPAN = [0 3000];
rule = 2;  %-> priority for flows
options = odeset('RelTol',1e-6,'MaxStep',0.005);

x0=[0; 0; 2]; 
x0=[1.153;2.476;2];
tau0=0;
s0 = [x0; tau0];
[t j s] = HyEQsolver( @f_h,@g_h,@C_h,@D_h,s0,TSPAN,JSPAN,rule,options);
x1=s(:,1);x2=s(:,2);q=s(:,3);tau=s(:,4);

figure(1) 
modificator{1} = 'b';modificator{2} = 'LineWidth';modificator{3} = 2;
plotHarc(x1,j,x2,[],modificator);  % plotHarcColor(x(:,1),j,x(:,2),t); 
xlabel('z_1','FontSize',18); ylabel('z_2','FontSize',18); grid on; box on;

figure(2)
plotHarc(t,j,q,[],modificator);
xlabel('t','FontSize',18);ylabel('q','FontSize',18); grid on; box on;
ylim([0.9 2.1]);

