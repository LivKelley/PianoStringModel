function FindDampingTime ()

Initial = linspace(.1,4,100);
Y = linspace(1,100);

for i = 1:100
    X = (AnimationwDamping_for_FindDampingTime(Initial(i)));
    for j = 1:20:5000
        if max(X(j:end)) <= .01
            Y(i) = max(X(j));
            break
        end
    end
end

plot(Initial,Y);

end