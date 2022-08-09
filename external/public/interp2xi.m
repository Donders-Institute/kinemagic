function dati = interp2xi(tim,dat,timi,method)

% check input
if nargin < 4
    method = 'pchip';
end

% check size of original data
sizdat = size(dat);
if sizdat(end) < 4
    error('number of samples is too small for sensible interpolation');
end

% check size of original time
siztim = size(tim);
if sum(siztim(1:end-1)>1)>1
    error('dimensions of tim not unambiguous');
end
tim = reshape(tim,[prod(siztim(1:end-1)) siztim(end)]);
if numel(tim) == length(tim), tim = tim(:)'; end
siztim = size(tim);
if siztim(1)>sizdat(1)
    error('dimensions of tim do not match dimensions of dat');
end

% check size of interpolated time
if length(timi) == 1
    ntim = timi;
else
    siztimi = size(timi);
    if sum(siztimi(1:end-1)>1)>1
        error('dimensions of timi not unambiguous');
    end
    timi = reshape(timi,[prod(siztimi(1:end-1)) siztimi(end)]);
    if numel(timi) == length(timi), timi = timi(:)'; end
    siztimi = size(timi);
    if siztim(1:end-1) ~= siztimi(1:end-1)
        error('dimensions of timi do not match dimensions of tim');
    end
    ntim = siztimi(end);
end

% loop over first dimension of tim
dati = nan([sizdat(1:end-1) ntim]);
for i = 1:siztim(1)
    % do not allow NaNs
    if any(isnan(dat(i,:))), continue; end
        
    % get original time array
    x = tim(i,:);
    
    % get new time array
    if length(timi) == 1
        xi = linspace(min(x),max(x),timi);
    else
        xi = timi(i,:);
    end
    
    % if loop over tim is needed
    if siztim(1)>1 || length(sizdat)>2
        % get original data matrix
        y = nan(sizdat(2:end));
        y(:) = dat(i,:);

        % interpolate new data matrix and place in new matrix
        yi = interp1(x,y',xi,method,'extrap')';
        dati(i,:) = yi(:);
    
    % if no loop is needed
    else
        dati = interp1(x,dat',xi,method,'extrap')';
    end
    
end