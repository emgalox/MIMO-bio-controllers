clc;
clear all; 
close all;
%%

[t,y]=response;

figure
hold on
p1=plot(t,y(:,1),'color','[0 0 1]');
p2=plot(t,y(:,2),'color','[1 0.55 0]');
hold off
p1.LineWidth = 2;
p2.LineWidth = 2;
xlabel('Time','FontName', 'Arial','FontSize',20) 
ylabel('Concentration','FontName', 'Arial','FontSize',20) 
legend(' Y1','Y2','Location','southeast','FontName', 'Arial','FontSize',18)
saveas(gcf,'FigureS7B.pdf')

%System response
%%
function [t,y]=response() 

%time
tspace=linspace(0,300,10000);

%parameters
b1=0.5; b2=2.5;d1=1.6;d2=1.6;a1=0.1;a2=1; k1=2; k2=4; k3=1; k4=0.1; n1=0.05; n2=0.05; th1=60; th2=35; ku=0.0096; g=0.028; Vm=10000; K1=Vm/(1*a1);
K2=Vm/(1*a2);K3=Vm/(1*k3);K4=Vm/(1*k4);K5=Vm/(1*k1);K6=Vm/(1*k2);dist=10;

[t,y]=ode23s(@sol,tspace,[0;0;0;0;0;0;0;0]);


%ODE model
function dydt=sol(t,y)
dydt(1,1)=b1 - (d1+g)*y(1) + (Vm*y(2))/(y(2)+K1) + (Vm*y(5))/(y(5)+K3) + dist*heaviside(t-150)  ;%Y1                                  
dydt(2,1)=b2 -(d2+g)*y(2) + (Vm*y(1))/(y(1)+K2) + (Vm*y(6))/(y(6)+K4); %Y2
dydt(3,1)= (Vm*y(1))/(y(1)+K5) - n1*y(3)*y(5)+ ku*y(7)- g*y(3); %Z1
dydt(4,1)= (Vm*y(2))/(y(2)+K6) - n2*y(4)*y(6)+ ku*y(8)- g*y(4); %Z2
dydt(5,1)=th1 - n1*y(3)*y(5)+ ku*y(7)- g*y(5); %Z3
dydt(6,1)=th2 - n2*y(4)*y(6)+ ku*y(8)- g*y(6);%Z4
dydt(7,1)=n1*y(3)*y(5) - ku*y(7)- g*y(7);%Z5
dydt(8,1)=n2*y(4)*y(6) - ku*y(8)- g*y(8);%Z6
end
end