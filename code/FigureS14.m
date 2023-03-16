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
saveas(gcf,'FigureS14.pdf')

%System response
%%
function [t,y]=response() 

%time
tspace=linspace(0,100,10000);

%parameters
b1=0.5;b2=3.5;b3=5;d1=1;d2=1;d3=1;d4=1;d5=1;d6=1;a1=1.5;a2=1;a3=2;a4=0.5; a5=0.4;a6=0.2;a7=0.3;
k1=1; k2=25; k3=10; n1=10;n2=10;n3=10; th1=12; k4=0.5;k5=10;k6=5;dist=2; 

[t,y]=ode23s(@sol,tspace,[0;0;0;0;0;0;0;0;0;0;0;0]);


%ODE model
function dydt=sol(t,y)
dydt(1,1)= a1*y(4)- d1*y(1) ;%Y1                                  
dydt(2,1)=a2*y(5) -d2*y(2)  ; %Y2
dydt(3,1)= a3*y(6) - d3*y(3)-k6*y(3)*y(9); %Y3
dydt(4,1)= b1 + k4*y(10) - d4*y(4) - a4*y(4)*y(3) ; %Y4
dydt(5,1)=b2 - d5*y(5) - a5*y(5)*y(3) + dist*heaviside(t-50)-k5*y(5)*y(8); %Y5
dydt(6,1)=b3 - d6*y(6)- a6*y(6)*y(1)- a7*y(6)*y(2) ;%Y6
dydt(7,1)= k1*y(1)- n1*y(7)*y(10); %Z1
dydt(8,1)= k2*y(2)- n2*y(8)*y(11); %Z2
dydt(9,1)= k3*y(3)- n3*y(9)*y(12); %Z3
dydt(10,1)= th1- n1*y(7)*y(10); %Z4
dydt(11,1)= n1*y(7)*y(10)- n2*y(8)*y(11); %C1
dydt(12,1)= n2*y(8)*y(11)- n3*y(9)*y(12); %C2
end
end