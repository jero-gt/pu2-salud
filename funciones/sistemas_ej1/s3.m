function y = s3(x)
    y(1)=1/4*x(1);
    
    for i = 2 : length(x)
        y(i) = 0.25*x(i) + 0.25*x(i-1) + 0.5*y(i-1);
    end
end
