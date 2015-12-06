% let's make a model for a mass on two springs. one end of each spring is
% fixed to a wall and the other end to the mass. actually at this point
% it's a particle, not a mass.

% hello

function piano_step_absolute_one()
% absolute first step: satisfy louise's paranoia
clf
hold on

%% parameters might be important

k = 10;                 % completely arbitrary k value of springs
x = 5.5;                  % at rest length of springs

%% initial values could also be important

y_initial = 1;         % initial y position 
vy_initial = 0;         % initial y velocity
lower_bound = - y_initial - 1;
upper_bound = y_initial +1;

Y_stuff = [y_initial, vy_initial];

%% now we get to make an ode function

[T,Y] = ode45(@vibration, [0, 100], Y_stuff);

%% now we get to make a function for the ode

    function derivs = vibration(T, Y_stuff)
        y = Y_stuff(1); %Unpack variables
        vy = Y_stuff(2); %Unpack variables
        ay = -k * (sqrt(x^2 + y^2) - x) * y / sqrt(x^2 + y^2); %Velocity equation (described by sheet) 
        delta_y = vy; % Change in y 
        delta_vy = ay; %Change in velocity of y
        derivs = [delta_y; delta_vy];
    end

%% some clever way to manipulate the Y vector

Velocity = Y(1:end, 1);

%% now how to make a graph
plot(T,Velocity);
axis([0, 100, -1, 1]);

%% now we label the graph 
xlabel('Time'); 
ylabel('Amplitude'); 
title('Mass Oscillating Between Two Springs');
end
