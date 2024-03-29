clc;
clear all; 
close all;
%%

[t,y]=response;

figure
hold on
p1=plot(t,y(:,1),'color','[0 0 1]');
p2=plot(t,y(:,2),'color','[1 0.55 0]');
p3=plot(t,y(:,1)./y(:,2),"--",'color','[0 0 0]');
hold off
p1.LineWidth = 2;
p2.LineWidth = 2;
p3.LineWidth = 2;
ay = gca;
ay.YLim = [0 5];
xlabel('Time','FontName', 'Arial','FontSize',20) 
ylabel('Concentration','FontName', 'Arial','FontSize',20) 
legend(' Y1','Y2','Y1/Y2','Location','southeast','FontName', 'Arial','FontSize',18)
saveas(gcf,'Figure4A.pdf')

% System response
%%
function [t,y]=response() 

%time
tspace=linspace(0,100,10000);

%parameters
b1=2; b2=1;d1=1;d2=1;a1=0.1;a2=0.4; k1=0.5; k2=1; k3=2; n=10;
dist=2;

[t,y]=ode23s(@sol,tspace,[0.0001;0.0001;0.0001;0.0001]);

%ODE model
function dydt=sol(t,y)
dydt(1,1)=b1 - d1*y(1) + a1*y(2) + dist*heaviside(t-50) ;%Y1                                  
dydt(2,1)=b2 -d2*y(2) + a2*y(1) - k3*y(2)*y(4); %Y2
dydt(3,1)=k1*y(1) - n*y(3)*y(4); %Z1
dydt(4,1)=k2*y(2) - n*y(3)*y(4); %Z2
end
end