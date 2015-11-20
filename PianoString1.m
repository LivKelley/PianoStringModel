function PianoString1
%% satisfy louise's paranoia first
clf
hold on

%% parameters and initial values

k = 10;
x = 1;
m = 1;

% here's a lot of initial values theoretically

m1_i = .5;
m2_i = 0;
m3_i = 0;

dm1_i = 0;
dm2_i = 0;
dm3_i = 0;

State = [m1_i, m2_i, m3_i, dm1_i, dm2_i, dm3_i];
New_state = [Y(:,1), Y(:,2), Y(:,3)];

%% an ode function

[T, Y] = ode45(@motion, [0,15], State);

%% 
%Plotting through a for loop 
for i = 2:n-1
    
    fs(i) = -k*(sqrt(x^2+(m(i)-m(i-1))-x)*sign(m(:-1)-m(i);  
    axis([0,15,-.5,.5]);
    plot(T, New_state); 
end 

 xlabel('Time') 
 ylabel('Position') 
title('Multiple Masses Wire Movement') 
    
end 