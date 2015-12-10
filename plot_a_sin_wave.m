function plot_a_sin_wave()

n=65;
State = zeros(1,n);
Distance = linspace(1,n,n);

% this makes the masses initial condition a sine curve
Vector = linspace(0,pi,n); %Changed 3 pi back to pi. (12/9/2015) 
State = [4*sin(Vector)];

plot(Distance,State);
axis([0 65 -4 4]);
xlabel('Time');
ylabel('Amplitude');
title('Initial Displacement of Guitar String');

end