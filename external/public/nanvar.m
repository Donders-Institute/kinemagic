function y = nanvar(x,flag,dim)

% dimension and size
sz = size(x);
if nargin < 3,  dim = find(sz ~= 1, 1); end
if isempty(dim), dim = 1; end
rsz = ones(1,ndims(x));
rsz(dim) = sz(dim);

% unbiased or biased variance calculation
if nargin < 2 || isempty(flag)
    flag = 0;
end

% input
if nargin < 1;
    error('??? Input argument "x" is undefined.')
end

% find nans
idx_nan = isnan(x);
x(idx_nan) = 0;
% number of non-NaNs
n = sum(~idx_nan,dim);
idx_allnan = n==0;
n(idx_allnan) = NaN;
% mean
mu = sum(x,dim)./n;
mu = repmat(mu,rsz);
% deviation from mean
dev = abs(x-mu);
dev(isnan(dev)) = 0;

% variance = (x-mu).^2 ./ n-1
y = sum((dev.^2),dim) ./ (n-abs(flag-1));