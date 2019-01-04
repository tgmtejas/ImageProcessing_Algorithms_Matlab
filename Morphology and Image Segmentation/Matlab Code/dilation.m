function fd = dilation(f)

% This function is used to perform dilation operaton.
% A 3x3 mask has been used.

[M, N] = size(f);

fd = uint8(255*ones(M));

for x = 2:M-1
    for y = 2:N-1
        if min([f(x-1,y-1), f(x-1,y), f(x-1,y+1), f(x,y-1), f(x,y),...
                f(x,y+1), f(x+1,y-1), f(x+1,y), f(x+1,y+1)]) == 0
            fd(x,y) = 0;
        else
            fd(x,y) = 255;
        end
    end
end

end