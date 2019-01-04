function fe = erosion(f)

% This function is used to perform erosion operaton.
% A 3x3 mask has been used.

[M, N] = size(f);

fe = uint8(255*ones(M));

for x = 2:M-1
    for y = 2:N-1
        if max([f(x-1,y-1), f(x-1,y), f(x-1,y+1), f(x,y-1), f(x,y),...
                f(x,y+1), f(x+1,y-1), f(x+1,y), f(x+1,y+1)]) == 255
            fe(x,y) = 255;
        else
            fe(x,y) = 0;
        end
    end
end

end