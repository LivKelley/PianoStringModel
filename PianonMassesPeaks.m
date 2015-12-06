function PianonMassesPeaks()
    function piano_n_massesA440
        %% satisfying paranoia
        clf
        hold on
        
        %% set the number of masses
        n = 20;
        %% parameters and initial values and making a vector and things
        
        % parameters
        %f = 0.75;     % Arbitrary constant that seems to yield the correct frequency*2
        k = 10^3;         % spring constant (currently totally arbitrary)
        x = 5.5;          % x distance between masses, spring rest length
        m = 1;          % mass of masses, totally arbitrary
        
        State = zeros(1,2*n);
        
        % that vector of positions and velocities (all positions, then all
        % velocities, so for n = 3, State = [p1;p2;p3;v1;v2;v3]% this makes the middle mass be at .5
        if mod(n,2) == 0
            State(n/2) = 1;
        else
            State(n/2 + .5) = 1;
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
        
        %% Find Peaks
        
        %    for x = 1:n;
        pks = findpeaks(Y(:,10)); %This finds peaks!
        Frequency = numel(pks)/T(end); %Amplitude output
        disp(Frequency)
        %% tell it how to plot
        ylabel('Peak Height');
        xlabel('Time');
        title('Position of masses vs. time');
        
        
    end
piano_n_massesA440()

end
