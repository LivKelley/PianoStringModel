function FindDampingTime_for_fewer_things()

Initial = linspace(.1,1,10);
Y = linspace(1,10,10);

for i = 1:10
    X = (AnimationwDamping_for_FindDampingTime(Initial(i)));
    for j = 1:20:5000
        if max(X(j:end)) <= .01
            Y(i) = max(X(j));
            break
        end
    end
end

plot(Initial,Y,'o');

end