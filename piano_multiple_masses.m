function piano_multiple_masses()

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

%% an ode function

[T, Y] = ode45(@motion, [0,1], State);

%% a motion function

    function res = motion(~, Info)
        m1 = Info(1);
        m2 = Info(2);
        m3 = Info(3);
        dm1 = Info(4);
        dm2 = Info(5);
        dm3 = Info(6);

        fs1 = (-k * (sqrt(x^2 + m1^2) - x)*sign(m1));
        fs2 = (-k * (sqrt(x^2 + (m2-m1)^2) - x)*sign(m2-m1));
        fs3 = (-k * (sqrt(x^2 + (m3-m2)^2) - x)*sign(m3-m2));
        fs4 = (-k * (sqrt(x^2 + m3^2) - x)*sign(-m3));
        
        fm1 = fs1 - fs2;
        fm2 = fs2 - fs3;
        fm3 = fs3 - fs4;
        
        am1 = fm1/m;
        am2 = fm2/m;
        am3 = fm3/m;
        
        res = [dm1; dm2; dm3; am1; am2; am3];
    end

axis([0,15,-.5,.5]);
plot(T,Y(:,1),'r*-');
plot(T,Y(:,2),'g*-');
plot(T,Y(:,3),'bo-');
xlabel('Time') 
ylabel('Position') 
title('Multiple Masses Wire Movement') 
end