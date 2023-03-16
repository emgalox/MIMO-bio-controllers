clc;
clear all; 
close all;
%%

[t,y]=response;

figure
hold on
p1=plot(t,y(:,1),'color','[0 0 1]');
p2=plot(t,y(:,2),'color','[1 0.55 0]');
p3=plot(t,y(:,1)-3.*y(:,2),"--",'color','[0 0 0]');
hold off
p1.LineWidth = 2;
p2.LineWidth = 2;
p3.LineWidth = 2;
xlabel('Time','FontName', 'Arial','FontSize',20) 
ylabel('Concentration','FontName', 'Arial','FontSize',20) 
legend(' Y1','Y2','Y1-3Y2','Location','southeast','FontName', 'Arial','FontSize',18)
saveas(gcf,'FigureS2B.pdf')

% System response
%%
function [t,y]=response() 

%time
tspace=linspace(0,450,10000);

%parameters
b1=2; b2=1;d1=1;d2=1;a1=0.1;a2=0.4; k1=1; k2=3; k3=2; k4=2; n=10 ;th1=4; th2=5; p=0.5;

[t,y]=ode23s(@sol,tspace,[0;0;0;0]);

%ODE model
function dydt=sol(t,y)
dydt(1,1)=b1+p*b1*heaviside(t-30) - (d1+p*d1*heaviside(t-120))*y(1) + (a1+p*a1*heaviside(t-180))*y(2) - (k4+p*k4*heaviside(t-270))*y(1)*y(3) ;%Y1                                  
dydt(2,1)=b2+p*b2*heaviside(t-60) -(d2+p*d2*heaviside(t-150))*y(2) + (a2+p*a2*heaviside(t-210))*y(1) - (k3+p*k3*heaviside(t-300))*y(2)*y(4); %Y2
dydt(3,1)=(th1-p*th1*heaviside(t-330))+k1*y(1) - (n+p*n*heaviside(t-90))*y(3)*y(4); %Z1
dydt(4,1)=(th2-p*th2*heaviside(t-240)) +k2*y(2) - (n+p*n*heaviside(t-90))*y(3)*y(4); %Z2
end
end