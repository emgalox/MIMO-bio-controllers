clc;
clear all; 
close all;
%%

[t,y]=response;

figure
hold on
p1=plot(t,y(:,1),'color','[0 0 1]');
p2=plot(t,y(:,2),'color','[1 0.55 0]');
p3=plot(t,y(:,3),'color','[0.4660 0.6740 0.1880]');
hold off
p1.LineWidth = 2;
p2.LineWidth = 2;
p3.LineWidth = 2;
xlabel('Time','FontName', 'Arial','FontSize',20) 
ylabel('Concentration','FontName', 'Arial','FontSize',20) 
legend(' Y1','Y2','Y3','Location','southeast','FontName', 'Arial','FontSize',18)
saveas(gcf,'FigureS9.pdf')

%System response
%%
function [t,y]=response() 

%time
tspace=linspace(0,100,10000);

%parameters
b1=2;b2=1.5;b3=1;d1=1;d2=1;d3=1;d4=1;d5=1;d6=1;a1=1.5;a2=1;a3=2;a4=0.5;a5=0.4;a6=0.2;a7=0.3;
dist=2;

[t,y]=ode23s(@sol,tspace,[0;0;0;0;0;0]);

%ODE model
function dydt=sol(t,y)
dydt(1,1)= a1*y(4)- d1*y(1) ;%Y1                                  
dydt(2,1)=a2*y(5) -d2*y(2); %Y2
dydt(3,1)= a3*y(6) - d3*y(3); %Y3
dydt(4,1)= b1 - d4*y(4) - a4*y(4)*y(3) ; %Y4
dydt(5,1)=b2 - d5*y(5) - a5*y(5)*y(3) + dist*heaviside(t-50); %Y5
dydt(6,1)=b3 - d6*y(6)- a6*y(6)*y(1)- a7*y(6)*y(2) ;%Y6
end
end