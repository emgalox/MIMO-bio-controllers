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
saveas(gcf,'FigureS7A.pdf')

%System response
%%
function [t,y]=response() 

%time
tspace=linspace(0,300,10000);

%parameters
b1=0.5; b2=2.5;d1=1.6;d2=1.6;a1=0.1;a2=1; degr=0.028; Vm=10000; K1=Vm/(1*a1);
K2=Vm/(1*a2); dist=10;

[t,y]=ode23s(@sol,tspace,[0;0]);

%ODE model
function dydt=sol(t,y)
dydt(1,1)=b1 - (d1+degr)*y(1) + (Vm*y(2))/(y(2)+K1)+ dist*heaviside(t-150)  ;%Y1                                  
dydt(2,1)=b2 -(d2+degr)*y(2) + (Vm*y(1))/(y(1)+K2); %Y2
end
end