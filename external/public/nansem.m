function y = nansem(x,flag,dim)

if nargin < 3;
    [m,n] = size(x);
    if m == 1 && n > 1
        dim = 2;
    else
        dim = 1;
    end
end

if nargin < 2;
    flag = 0;
end

if nargin < 1;
    error('??? Input argument "x" is undefined.')
end

y = nanstd(x,flag,dim) / sqrt(size(x,dim));