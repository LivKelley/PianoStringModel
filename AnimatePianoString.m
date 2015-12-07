function AnimatePianoString ()
%% satisfying paranoia
clf
hold on

%% set the number of masses
n = 100;

%% parameters and initial values and making a vector and things

% parameters
k = 10;         % spring constant (currently totally arbitrary)
x = 1;          % x distance between masses, spring rest length
m = 1;          % mass of masses, totally arbitrary

% that vector of positions and velocities (all positions, then all
% velocities, so for n = 3, State = [p1;p2;p3;v1;v2;v3]
State = zeros(1,2*n);

% this makes the masses initial condition a sine curve
Vector = linspace(0,pi,n);
State = sin(Vector);

% % this makes the middle mass be at .5
% if mod(n,2) == 0
%     State(n/2) = .5;
% else
%     State(n/2 + .5) = .5;
% end

%% a vector for the for loop

am_vector = zeros(n,1);
vm_vector = zeros(n,1);

%% an ode function

[T, Y] = ode45(@motion, [0:.01:10], State);

%% the actual most important motion function

    function res = motion(~, Info)
        m1 = Info(1);
        
        fs1 = (-k * (sqrt(x^2 + m1^2) - x)*sign(m1));
        fs2 = spring_force(Info(1), Info(2));
        
        fm1 = fs1 - fs2;
        
        am_vector(1) = fm1 / m;
        
        for i = 2:n-1
            fsi = spring_force(Info(i - 1), Info(i));
            fsi_1 = spring_force(Info(i), Info(i + 1));
            
            force = fsi - fsi_1;
            
            accel = force / m;
            
            am_vector(i) = accel;
        end
        
        m_last = Info(n);
        
        fs_last = (-k * (sqrt(x^2 + m_last^2) - x)*sign(-m_last));
        fs_nearly_last = spring_force(Info(n-1), Info(n));
        
        fm_last = fs_nearly_last - fs_last;
        
        am_vector(n) = fm_last / m;
        
        vm_vector = Info(n+1:end);
        
        res = [vm_vector; am_vector];
    end

    function res = spring_force(m_n, m_n1)
        res = (-k * (sqrt(x^2 + (m_n1 - m_n)^2) - x) * sign(m_n1 - m_n));
    end

%% Find Peaks
%This function helps to define the periods of the graph.
%pks = findpeaks(Y(:,10)); %This finds peaks!
% Frequency = numel(pks)/T(end); %Amplitude output
% disp(Frequency)

%% Make an X Vector
figure;
 pause;

for i=1:1000;plot(Y(i,1:100),'o');axis([0 100 -.5 .5]);drawnow;end
pause
% 
% X = linspace(1,n,n);

% animate_func(T,n);

% %% tell it how to plot
%     function animate_func(time,number)
%         
%         % Animates the string. Should plot y direction and create connectors in
%         % between masses.
%         
%         % Minimums and maximums help define the axis.
%         
%         for t = 1:length(time) %Find syntax
%             % Prepares the function for graphing.
%             hold on
%             clf;
%             for j = 1:number % Defines the time interval for the function.
%                 minX = X(1);  % Describes a minimum of a given period defined by n
%                 maxX = X(end); %Input min and max based on the equation
%                 minY = -.5; % Input min based on the equation
%                 maxY = .5; % Input max based on the equation
%                 axis(minX, maxX, minY, maxY); %Input decided axes %l/#*j (figure
%                 draw_func(y(t,(1:.5*j), 'or-')); %Draws the function plotting time by every second mass.
%             end
%             drawnow; % Continues drawing the function
%         end
%     end

%% Plot things
ylabel('Position');
xlabel('Time');
title('Position of masses vs. time');

end