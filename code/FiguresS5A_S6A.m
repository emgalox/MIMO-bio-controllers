clc;
clear all; 
close all;
%%
s=[0 0.01 0.1 1];
y1=zeros(10000,length(s));
y2=zeros(10000,length(s));

for i=1:length(s)
g=s(i)
[t,y]=response(g);
y1(:,i)= y(:,1);
y2(:,i)= y(:,2);
end

figure
hold on
p1=plot(t,y1(:,1),'color','[0 0 0]' );
p2=plot(t,y1(:,2),'color','[1 0 1]');
p3=plot(t,y1(:,3),'color','[0 0.5 1]');
p4=plot(t,y1(:,4),'color','[0.4 1 1]');
hold off
p1.LineWidth = 2;
p2.LineWidth = 2;
p3.LineWidth = 2;
p4.LineWidth = 2;
xlabel('Time','FontName', 'Arial','FontSize',20) 
ylabel('Concentration','FontName', 'Arial','FontSize',20) 
legend(' γ=0','γ=0.01','γ=0.1','γ=1','Location','southeast','FontName', 'Arial','FontSize',18)
saveas(gcf,'FigureS5A.pdf')

figure
hold on
p1=plot(t,y2(:,1),'color','[0 0 0]' );
p2=plot(t,y2(:,2),'color','[1 0 1]');
p3=plot(t,y2(:,3),'color','[0 0.5 1]');
p4=plot(t,y2(:,4),'color','[0.4 1 1]');
hold off
p1.LineWidth = 2;
p2.LineWidth = 2;
p3.LineWidth = 2;
p4.LineWidth = 2;
xlabel('Time','FontName', 'Arial','FontSize',20) 
ylabel('Concentration','FontName', 'Arial','FontSize',20) 
legend(' γ=0','γ=0.01','γ=0.1','γ=1','Location','southeast','FontName', 'Arial','FontSize',18)
saveas(gcf,'FigureS6A.pdf')


%System response
%%
function [t,y]=response(g) 

%time
tspace=linspace(0,300,10000);

%parameters
b1=2; b2=1;d1=0.9;d2=0.9;a1=0.1;a2=0.4; k1=0.5; k2=2; k3=0.5; k4=2; n1=0.5; n2=0.5; th1=4; p=2; 

[t,y]=ode23s(@sol,tspace,[0;0;0;0;0;0]);

%ODE model
function dydt=sol(t,y)
dydt(1,1)=b1 - d1*y(1) + a1*y(2) + k3*y(5) +p*b1*heaviside(t-100) ;%Y1                                  
dydt(2,1)=b2 -d2*y(2) + a2*y(1) - k4*y(2)*y(4); %Y2
dydt(3,1)= k1*y(1) - n1*y(3)*y(5) - g*y(3); %Z1
dydt(4,1)= k2*y(2) - n2*y(4)*y(6) - g*y(4); %Z2
dydt(5,1)=th1 - n1*y(3)*y(5) - g*y(5); %Z3
dydt(6,1)=n1*y(3)*y(5) - n2*y(4)*y(6)- g*y(6);%C
end
end