function y = sc(x,distx,disty)
% SC normalizes an input vector. It assumes that the vector x comes from a
% [min(x) max(x)] distribution, unless otherwise specified. By default, it
% scales to a [0 1] distribution, unless otherwise specified.
%
% FORMAT:   
%   full    - y = mc(x,distx,disty);
%   minimal - mc(x);
%
% INPUT:
%   x       - integer or boolean 
%               example: x = 0;
%   distx   - vector distribution minimum and maximum
%               example: distx = [-1 1];
%   disty   - target distribution minimum and maximum
%               example: disty = [0 1];
%
% OUTPUT:
%   y      - normalized value between -1 and 1
%
% created by Lennart Verhagen, jun-2009
% L.Verhagen@donders.ru.nl
% version 2009-06-09
%--------------------------------------------------------------------------

% set defaults
if nargin < 3
    disty = [0 1];
end
if nargin < 2
    distx = [min(x) max(x)];
end

% check input
if numel(disty) > 2
    warning('LENVER:meancorrect','The target distribution minimum-maximum range may only contain 2 values, taking min and max.');
    disty = [disty(1) disty(end)];
end
if numel(distx) > 2
    warning('LENVER:meancorrect','The vector distribution minimum-maximum range may only contain 2 values, taking min and max.');
    distx = [distx(1) distx(end)];
end

% normalize to [0 1]
dev = distx(2)-distx(1);
x = x/dev;
x = x - distx(1)/dev;

% normalize to disty
dev = disty(2)-disty(1);
y = x*dev;
y = y + disty(1);