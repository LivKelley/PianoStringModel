function the_code_to_animate(Result_matrix)

figure;
pause;

Dimensions = size(Result_matrix);
end_loop = Dimensions(1);
n = Dimensions(2);

for j = 1:2000
    for i = 1:end_loop
        clf
        plot(Result_matrix(i,1:n));
        axis([0 n -8 8]);
        drawnow;
    end
    pause;
end

end