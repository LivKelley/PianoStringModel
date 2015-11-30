function piano_n_masses
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

% this makes the middle mass be at .5
if mod(n,2) == 0
    State(n/2) = .5;
else
    State(n/2 + .5) = .5;
end

%% a vector for the for loop

am_vector = zeros(n,1);
vm_vector = zeros(n,1);

%% an ode function

[T, Y] = ode45(@motion, [0,100], State);

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

%% tell it how to plot
for j = 1:n;
    plot(T, Y(:,j));
end
ylabel('Position');
xlabel('Time');
title('Position of masses vs. time');

end